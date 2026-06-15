Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC86CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZBQS-000769-2M; Mon, 15 Jun 2026 13:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBQP-00075p-Ee
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:48:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZBQN-0005ne-NM
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 13:48:41 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFiMxE1015460
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PsOHIbnEIxtrZrdmf+H0zBchvHIy5nwLHlc+l9teQ/s=; b=Y82G1FsYDeF9PH57
 EU7JdgFE1aFgKJGk8Le3kwl+ecBJ2geMd6Cc7+ZpYTt0PlhdjMo7vJmvTb99TI6z
 f3JrcIcaUY1XB72m+CtvFSC16mmH9xaPBQKJzALxIo2hgmqr7UdYgVblL61LTfKt
 phCt47Mmzz7ZeYHtD6cJG08A2CWIkZFo3k7FddtgGkxq209n693bmrfOr6ofQ8fu
 LCOz9Aw9F+YPUZ3fDHw6kelHC09WTeDYyGRnuYf4UEow8DgxmIiZgzlArJxFU7Nu
 1LB+gHBWtyPXVt9ldssIkD4vj5WnMsZrzhppNllYzSTl3tNId8IUjcA6yalWwobX
 TeJjTg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etd2camc4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 17:48:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30761ab3483so291858eec.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781545716; x=1782150516; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PsOHIbnEIxtrZrdmf+H0zBchvHIy5nwLHlc+l9teQ/s=;
 b=QHg9vCeiy8NNHSWNfjQL2PuZxYndTR1Yjk6k9xtfhr/vytOjDhuzbrgejrV4C5KZ/I
 T5Y/2a7/04NFYYwavtmFkmTHr5EGJFhs6R6lsdc+XIOLfRQpr5iAOg2wUADtT04ZQ8f6
 Ob9mjcN+gDNbEk6WJbo0nolW/ppgnQhwDKVZHAkhW3Y8AFi3ATt38OQJziRyrFvHTo6D
 BN5ODj+H8+o9ht/w6x3ojFI+usn0bfAGguwN3ZzG4N7btpRUBqh/GaKsYKcjoLLhj9l1
 b1C3fv+p04dsqx+l78dDfhX1nGx563G6mxNO9By1wqPU7RZ2lHv9Q2SXt0eFR0Wh+Jy3
 Cibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781545716; x=1782150516;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PsOHIbnEIxtrZrdmf+H0zBchvHIy5nwLHlc+l9teQ/s=;
 b=kDuZaGAullOi8F/9BL/kK/ztA8yw1UsZlLnKZX8vo0fW9dw2JqUNzJ+zemUCnnYEyv
 QqSWRbfHCmQ9JcBqrfOpLwRKltLU/i3Ygxujw+4/5LoeJHznhz5u0P4qC/NRZqSUa6Ue
 bSzcnQakKtM6xdw96Jx+yynGZKgaoFEKQ6Z/Q0c8IxYQPrYCeyq8nkRjNEyl4kiaX3+7
 gTifsSI/Wk9Bo2Nf8tXRcmLvtK3Zrj79fXIAaEnF4sant4stF/dMVXBWtsrrH28tblwl
 9JRXfR7ZqAPXW5QzVvRLbMa+GuRAkqFXOGqcVquhofa0ULrKj5JF+dXdiIS3dJ4B7Oem
 qDLQ==
X-Gm-Message-State: AOJu0YztmrN/DA516/SCl+GrgJpAbW0UQRuXdANkhmsxxgOIynOdr5uH
 H7ruMZkky9YpGwKjzdgtLEplqZ0kRm8QjWWh0pqdE7+QU/PNEIWnFPFb5gO+LNI9Kk5TpvnVWgh
 Pn1p/yXSkGIm3Iy0GkwtW3GC/IjqHEpS5iTRLzHV0a1xWvKOY1hF23CJBu37XsjxyBw==
X-Gm-Gg: Acq92OHeWXvdpNhbIa232Oxia7eiJm8w+E93NosIvG2CbCxHnNpVGccEcq7cH3zTy4X
 0w+ZLmHEwL/MPS1SU/PkmVRRxwgH83GxcD1fIJYsXjlfa14Ci9KN0/1uU+ObGs8/hTZOk8556r1
 LIn5v+44RezJh2JZkZajbphwDFJBY748Uj8j8mrkEq8IBT85oQaOewbfS7Uo3QDaaNq+NMPe+BU
 WUUIXEgDNvjjIHaDcTiSthTNJgPZdgX9DTGOy4yJ94g5XPo7k2jViyn+A5Oar57glA5de2NnsYR
 5fhYig0rFF4WcqT3mMQb8DwnBMUURlEkXOwNbqvDjmjPYcfQ6I7TGuuVWTqUhfk88L34xVW/9o3
 ViPhcnG5f5w2mbrJ4HjpCjt+oZydfp7wx2NqZyS++pGhDnXVtPraRKzEObvW6f2vfoYYYHPAWd5
 w+fe2/z0T9/Y2Gcg==
X-Received: by 2002:a05:7300:a54c:b0:2f2:5c68:5052 with SMTP id
 5a478bee46e88-30ba5b1c82fmr174903eec.13.1781545716357; 
 Mon, 15 Jun 2026 10:48:36 -0700 (PDT)
X-Received: by 2002:a05:7300:a54c:b0:2f2:5c68:5052 with SMTP id
 5a478bee46e88-30ba5b1c82fmr174871eec.13.1781545715779; 
 Mon, 15 Jun 2026 10:48:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e91f88bsm15763996eec.16.2026.06.15.10.48.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 10:48:35 -0700 (PDT)
Message-ID: <fb2f9abb-64bd-45c7-921a-3c60ea6711dc@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 10:48:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] net/af-xdp.c: maybe-uninitialized warning with
 gcov build on ubuntu2404
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Ilya Maximets <i.maximets@ovn.org>
References: <20260610192222.2709135-1-pierrick.bouvier@oss.qualcomm.com>
 <20260610192222.2709135-2-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260610192222.2709135-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX4UngXMltNdY3
 wlmuP7ahhlaR8CabLlGoBDuET8vZdwyadBkKeTuNga4UE5mB6V3+Z8iPfrRzlDyzNeZahbIW1gR
 A4vNYZpWCj3ZN/nyMHscPeghv/ESyTzSgnx3vbHg+Ob9u0npCVe2iiut44pR9XqwVcjyUrkXgyS
 aZV/DPf8KzeASAfOsNX/CTQSjluyFDi/ButmTjljIzdHx+ht1QDHrQeRHM6435yU9sGEC8Mu8xr
 XDhqTShBECi5efoUGdchHK7oCZFbfnBj6viUr/Utwfl1VU8z0vVatanMoSt7MBCNUIL6ZkmjjV5
 EZ1BwYiJpO0PqRpns4/iGIrrH1DRRy/FEWxo6s4P4go2XkKsUExVcJDrw2/m0Seq7wUAppRh05Y
 QRt3ZOkt8kTdGf1HM5z1XAqTZUe7gVwxsnjEcTTrsRZVLWjtpGsm1yFA3MCqRLAXyjfMDGOluYc
 BD51rgpOzvOlS6Vnm3A==
X-Proofpoint-ORIG-GUID: kPUj2Ko6-QSphWOxtDZNWLys4JbN7JxD
X-Proofpoint-GUID: kPUj2Ko6-QSphWOxtDZNWLys4JbN7JxD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4OSBTYWx0ZWRfX1ISr1fw3IdSm
 UREQA0pEp6a/gBZ29UIdNwL2BhSp7kkKs1wuT62HNRsQEnDqdlwTFHFG7sKNH4RYvD6wDKfPvEr
 Yoii3CWXjw0T8x6znLjxp9FcYy0Tddw=
X-Authority-Analysis: v=2.4 cv=MsRiLWae c=1 sm=1 tr=0 ts=6a303af5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=_4XgQexuKuga4rjXeI0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150189
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/2026 12:22 PM, Pierrick Bouvier wrote:
> This is a false positive, fixed by explicitly initializing
> variable to NULL. Variable is always initialized during the for loop
> above, which is guaranteed to run since queues >= 1.
> This is correctly detected for normal builds, but not for gcov builds.
> 
> In function ‘af_xdp_read_poll’,
>     inlined from ‘net_init_af_xdp’ at ../net/af-xdp.c:546:5:
> ../net/af-xdp.c:78:10: error: ‘s’ may be used uninitialized [-Werror=maybe-uninitialized]
>    78 |     if (s->read_poll != enable) {
>       |         ~^~~~~~~~~~~
> ../net/af-xdp.c: In function ‘net_init_af_xdp’:
> ../net/af-xdp.c:461:17: note: ‘s’ was declared here
>   461 |     AFXDPState *s;
>       |
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  net/af-xdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 1ffd6363a8c..72d75748c6d 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -458,7 +458,7 @@ int net_init_af_xdp(const Netdev *netdev,
>      g_autofree int *sock_fds = NULL;
>      int i, queues;
>      Error *err = NULL;
> -    AFXDPState *s;
> +    AFXDPState *s = NULL;
>      bool inhibit;
>  
>      ifindex = if_nametoindex(opts->ifname);

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


