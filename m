Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3B99CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhG1-0002BB-Kw; Mon, 22 Jun 2026 12:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbhFz-00025X-S7
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:12:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wbhFy-0000Ks-7r
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:12:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFX7561591648
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kozxeXefiWovWAvXq0D8VtvvN+D8AJMNn1fluYdyE3I=; b=GuQGNmih6lETKpVu
 SyfGTc9KC4OS2Bs2mbuCIr/wR8loVEf4o3Ix8jeerz1LK7axbdYX8qFbKIQCg0s2
 q/boqnb1iwbyRGi1bAwzn8eIgDQnMS24HQZTUctGV2BsOv7nHbDcbvTc3mKO1Hxs
 RdoiBOpob9paEwHma4Dn1VveiqprLbS/otn8YaZJ+K6kU+OKbzT6DwoDZSmPlv6K
 fXjcvMhdrE/VOxC3prBx0ZiOdRhLHxiO1/Huidh3CG+1z69836O38AacYNdWaYZt
 UMulmCtREFdCkzLzGaGHHxXCugeifIeEeoeRfb2yWeOToTrovIvb0hs3oHGWhVEt
 NJTdQQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5n40pwf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:12:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso54874eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782144735; x=1782749535; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kozxeXefiWovWAvXq0D8VtvvN+D8AJMNn1fluYdyE3I=;
 b=jjR38Rlj6gfAUk9H2p0jfBgz5mh+LlA8CuI4Qgi+DJHJEuxEgb0fC8cAzE+q7FRUrE
 zjl/HoWQlw/fYcIT299+VF533fSiBRWJKvW0aQ938bTw3ml8syf4M5LUGWl7Hrairw4R
 YrYL6MQWW7d86XUGtC61HM7YCfbMLKNOPAm+QOqKQ63kNAhP1IkqV3BvO+jPUsHroGUG
 iyRkmpKsNrflTVIr7j+lTKbVsH2hTp6goTdXlA6EUVzqiss/u8CUZqoerxs6NfswlX9Y
 VggvimuBdUtzff7pFhF29Ay48NPkDxd/WsaWyoZCddewag4CU/kWbKCA5SJ3iESFitS1
 Vcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782144735; x=1782749535;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kozxeXefiWovWAvXq0D8VtvvN+D8AJMNn1fluYdyE3I=;
 b=Ah+7TJI8HhqikCOmwsD4G/Dsu+gD6pPgN5rGU1+TL4ve9rVE8arU6M7QrNDE7Plr0J
 r7zPN/K7P++7GLdbaslyRfOEN98YfceWBJtzXooXkW9DeSA40D747iN3uwQIsCudxELL
 HDX44szFH3cKet/SrOA5waxqrQQArhUWwMpQmxSYgserl17N+bYVBcRmjVoKZJbeMUt7
 qQoTbnQfrRLKgiuz7UOls164EvwTZoeIg8T7Jf28Mlsbq7Ox5e8SFSI04gq3YPPHKU4s
 NoxaPAWfrboGlYzQIqDb+STYn5HV6PBd0S/SLm6TXYhjrxe9bejA13UvdkmUE5O6jpHJ
 Ncsw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrBK0VN+DPYEAj/2xWacHGpViNWvPT2mO0qD6HDIYVceED3TtjRZCt4NlHKF+m1YJj6aLsHIUMtZTyE@nongnu.org
X-Gm-Message-State: AOJu0Ywu6gZPTLnkeM8LXGCDEjVBW7WW3humO6kFbE2IX4/uuJoMR8qY
 HzFTsv/ZlYWAIEImkWdP52Pp1w30Adz7y1k9O/P8LjueCHMf+ca5f2vUlgA83CJW7Sh5kfBGJBc
 rau7tUF+3ybn6pe8z4Bcztr4ibCwPbpg3r5ZCLNXAhyDbYKo1ryfb+Ixlog==
X-Gm-Gg: AfdE7cnFk4Bc08hX0Y/rBQBQKzfh3DBP+0AMWpHoA4y/V6D/xh6vB5Vg7etmJ5OpmVY
 bUU7pFHGGHM5nM9kTg8+9n/BiNtWCMeMwvxK8HiodkdTnXBztBV0pJJZGbVUT59DWgWMIY+MwxZ
 2NnMdppJ/U8N2dLCgsHA+zzihv0Thxq6al4XI+FNx3B/aSAplNd5FtB/J2FCiENnPEgVRhMSnBj
 73e3Z5TwgiZBKLGBk5FZ4StXLEwMq38f1BVzqxVszEdxI3XzfvNi5F0TcDrgnoOk44vZui6kjq3
 rDuVVtUreBRUg6/Sazj3P9f9zcZDGjRl5chpuwYmZS1JytSetl4n3SuiDpCFWYZvJHJVNwvfF75
 mS6xmM29zwCW2KcyTM3nf+df87whvMytXQFafICMUmhJ5aZ6ozY59gBWYj8JhTtYoGYfIskXNUh
 FPdy4=
X-Received: by 2002:a05:7300:724d:b0:30b:c0b4:db42 with SMTP id
 5a478bee46e88-30c555b86a0mr110310eec.11.1782144734735; 
 Mon, 22 Jun 2026 09:12:14 -0700 (PDT)
X-Received: by 2002:a05:7300:724d:b0:30b:c0b4:db42 with SMTP id
 5a478bee46e88-30c555b86a0mr110269eec.11.1782144734263; 
 Mon, 22 Jun 2026 09:12:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm9894127eec.15.2026.06.22.09.12.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 09:12:13 -0700 (PDT)
Message-ID: <99ada24c-ead3-4ecb-bc40-e01d084f55fa@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 09:12:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] plugins: fix syscall filter return value type
To: Ziyang Zhang <functioner@sjtu.edu.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Alex Bennee <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhengwei Qi <qizhwei@sjtu.edu.cn>, Yun Wang <yunwang94@sjtu.edu.cn>,
 Mingyuan Xia <xiamy@ultrarisc.com>, Kailiang Xu <xukl2019@sjtu.edu.cn>
References: <20260618082426.790315-1-functioner@sjtu.edu.cn>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260618082426.790315-1-functioner@sjtu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfX4ARONJQdK6cw
 AKMVClkRfkndLWvBSPF85m+t3eWoCYHPOz6dgU2co2hDr/ChPkd6jI7hWa2mYs3rEcqVgmVsE01
 MtoaI2AFh6jCyTSFT0WTN7kS5AN7uAU=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a395edf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EGNn8dKErvrxVkJEOSoA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: yxwrXLI0YD3sm6RXMOkPssuFJL3uvNrZ
X-Proofpoint-GUID: yxwrXLI0YD3sm6RXMOkPssuFJL3uvNrZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfX05Gq7I882HxV
 irttIKfTyQd0AzCB0JAlHij7tqtZoYtWRiQKMsQDEPGTWSyRhjHCluXQDinqTBCwbr/v+VVk8/5
 TgxtHjZSggdV8VAF0QLsnci+ghNR5/nr1VJVt2w25ghZoBA7XRhCrHBqSIFHr+IKPkdiHxRzjEs
 pMDOjvPbExVzvmd+PmvQ0UIK1YIl9ZysrW41pFrcMGSy4O++ph9pp3nX3ekoKSR0G5u9JMyr5vw
 9n/kn7CC654lKfabaKYodvnqDt2gdyTnN4zi71BHUnvNhen27l6ajo1iopTsMzN2NR+r9OWe8Rt
 gVaPjgo1BID92ypSe+7aB/jOZ66s2dbAs+EqNaUQKH4h8Xe+lbADQohArNj2VKmbM+ESrGGKpr+
 9ooZGZi5KOG++exOhsu+hqW8fb9KlPzZuc/BzKjG3eUxOLegP4gaJqh5nIUHHyo/NIFH6yFa1VH
 eVJ2mxy21ik0feA9/VQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220160
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

On 6/18/2026 1:24 AM, Ziyang Zhang wrote:
> Hi,
> 
> The sysret value of the syscall filter callback is declared as uint64_t,
> but it is semantically signed: the negative range encodes errno. This
> makes it int64_t, matching the ret parameter of
> qemu_plugin_vcpu_syscall_ret_cb_t, which already uses int64_t for the
> same syscall return value.
> 
> As discussed on v1, this is not a correctness fix (the filter only sets
> sysret, so the bit pattern is the same either way); it is a consistency
> and readability improvement, so that the same syscall return value is
> typed the same way on the read side and the write side.
> 
> I did not bump QEMU_PLUGIN_VERSION, since this only changes the
> signedness of an existing argument.
> 
> v1: https://lore.kernel.org/qemu-devel/20260612054800.587419-1-functioner@sjtu.edu.cn/
> 
> Changes since v1:
> - rebased onto current master, where the syscall callbacks now take a
>   userdata argument; the filter signatures were adjusted to keep that
>   while changing only the sysret type. No functional change otherwise.
> 
> Thanks for your review.
> 
> Ziyang Zhang (1):
>   plugins: use int64_t for the syscall filter return value
> 
>  include/plugins/qemu-plugin.h | 2 +-
>  include/qemu/plugin.h         | 4 ++--
>  linux-user/syscall.c          | 2 +-
>  plugins/core.c                | 2 +-
>  tests/tcg/plugins/setpc.c     | 2 +-
>  tests/tcg/plugins/syscall.c   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)
> 

This was merged into master (b83371668192a705b878e909c5ae9c1233cbd5fb).
Thank you for your contribution!

Regards,
Pierrick

