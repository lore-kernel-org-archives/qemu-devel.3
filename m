Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716B4C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBjT-000222-N6; Fri, 26 Jun 2026 14:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBjM-00021R-IH
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:56:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdBjK-0007T4-Db
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:56:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QFiu0Q1286204
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:56:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 idxkczJVWJvSiv3x1LW9UyTNRbIIrCihjxGWosCiMdQ=; b=R4lrfVYkeSyhZxy1
 in3q26fMp0AonKKhFNPDsHh04Z43nav4t6vwwVdYNv0WEyl7y4Ems+PMk94f7OgV
 BccOjnGjzv46or+E6BEQOgA4O/mgYhLnutYq65BR/k1vir3AiKVh5+UEiCMEF6k0
 Pg9ZclY4uu6quLSz75kFzzXS0CEUUcgPc+31G7veHfZukQH5Q+eReTCATRos+wfC
 FM9oCLGq2fvJhdwg+AddWSmW9moDJxY4oceG9oZmBdtEc686F8AWRhTBMeFVr4RQ
 J6z7H9OkMO+dmUiUzSxvnT7N5BTf+II0x0jffEht9PFL2dIvXr51p+ZbVrTsuACz
 c2sACg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1t0qsb04-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 18:56:43 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c42d96713so992696eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782500202; x=1783105002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=idxkczJVWJvSiv3x1LW9UyTNRbIIrCihjxGWosCiMdQ=;
 b=X5wf9SYTZftqKN66grkbf8A22bXzgLfWZhEAvgWpXnzyZ4J2SQHqh5SCTZjrDqROlH
 NYay+MB2tTk8PVFHh4g/mHLEb02iSfh7Bc2nVclzr8iFKYLVgKaxim+2iZ0fgjNmASlw
 +PqbySEpBBC2Pxnr4dYlppNHNUb69edK5Jzt6D9Jznhealpq0gRbllq1Ox2oU4OFnbMb
 JntAb2NxliLeE3oTkpua8aCoV2re4gsZfCSZ6DMBq4GcMUse628tp4NCmLHnyh8OIZB6
 D4ZCGsmaIJtPyshDhcfmeSo9DQr63GVmp+b7k8XJagZ55fH1rP2PC0ZA4Rw7MD67ikx3
 VNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782500202; x=1783105002;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=idxkczJVWJvSiv3x1LW9UyTNRbIIrCihjxGWosCiMdQ=;
 b=B5kM5ZK9kgDFBaFK5RIKYRPN/hTkI+qpWIZPxzjuNdj9tYDbKTurjQpKcYKwAp3vi0
 4D/IBV+rU89xDKi7fb2OAVm9zbA9z5+DkxbwrmsB8QPy11W0+3D50OgVBHDeFnffMRIl
 kkff2rlP8Bc2Pmw7ht8He5BbxYihouvyCdblTiezH2ynx2IZ53xtbRMwO7ojWl24zBxG
 ky04tIU0ith28ebvyK+MS4PGx0LY/lR1LEtM6h6ZHuganfqScwaAx491xYTWQkNH2s1q
 Wc5Cth7IpWkh9MLEudDdFuYvXp/yeNSMUelEpO75/5S8zqwo+UdSPpdQ35AkZtBqfMkf
 hwlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp1K6svS2/Pigp3d3nvvoO/t4uNiTuYSLZvUDtUVNrtbG/ATJS66AscboLeCGYpqCccSakiL+mTOiGA@nongnu.org
X-Gm-Message-State: AOJu0YxOMVPrjWQxWzE/QcUmgV5K3hf97fW6X3OmefVkbxhZIdLHjY21
 gb/eWpGJ7h7GK6X3ON/Viu31mu/OevCGVdKKMNemH08zfyAqvDTU2KVdoiS7+04fdDt4LL4KoUX
 f0Xc2Kd6t3xcY9JB7XNorpBIxkBxJbr4RigwkuDboGKHcR15JfaTIDDSsMQ==
X-Gm-Gg: AfdE7cnuBlKaGwkHxsruv2GZIh3W6EQsqHCRta+dgEFLYfTHsd6PJLehpF2LT+lKhd2
 FCZjZ66VUwetrBLzxOkvakLR3iEhZvnxbIBIa0IxPaOTrRZ+5baRVrogBgTUAri8eMEfAUv5V4R
 6I15Yi4zgLSiswxxzIHS7KvJMqqH63/hwfTyTCGyn/VV9sGllIJsN98fa2vF/UXVsRn7RXrI++3
 i+jPh9tEHDKtUhUvYswjKVCFmgCrjLyzO5ElSnM6VHcPBg51PEQvFvtiXBLFhz2kR0zYzJNcb/M
 PRfoNQj9LpxFhuK33YhLtEqSisIkbxmTC97Blmx9XTEH4KhgkM077fRnr/zJQZ1rwAu0iTWaEcm
 sGXL5uZU5a2/jtzVpVJ0qU145FTruvIej67VoE3cy/lL2YcVRkCPgR5t27CJ7UCNOL82ReqCTbh
 YXo1k=
X-Received: by 2002:a05:7300:e790:b0:30c:ab4f:9ba3 with SMTP id
 5a478bee46e88-30cab4f9f4fmr1029535eec.43.1782500202368; 
 Fri, 26 Jun 2026 11:56:42 -0700 (PDT)
X-Received: by 2002:a05:7300:e790:b0:30c:ab4f:9ba3 with SMTP id
 5a478bee46e88-30cab4f9f4fmr1029485eec.43.1782500201667; 
 Fri, 26 Jun 2026 11:56:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1ab6sm32398682eec.15.2026.06.26.11.56.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:56:41 -0700 (PDT)
Message-ID: <3e8ed443-58b4-47bc-a609-06680742bab7@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 11:56:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/system: add general note about architecture and
 machine differences
To: Linisha <linisha232@gmail.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, pbonzini@redhat.com,
 mjt@tls.msk.ru, philmd@mailo.com, berrange@redhat.com
References: <20260625192121.1887-1-linisha232@gmail.com>
 <20260626181118.1136-1-linisha232@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260626181118.1136-1-linisha232@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE1NiBTYWx0ZWRfXyFmg9sSAyWHV
 VSZodD7TUVya+eytaPIFBpF4MEqfzaXGEwAKRBTyT49Si33kf+PCOSGHDQ8F8zXsNoVkd/2pX8E
 nwr9NSpWUzhUZry5owSEw9iCm0qi1I4=
X-Proofpoint-GUID: QxCoQoz8Lhdt3jdDMhv5EEFQcEAdObAl
X-Authority-Analysis: v=2.4 cv=StqgLvO0 c=1 sm=1 tr=0 ts=6a3ecb6b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=eUfwmhwwi5oaL508dmgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: QxCoQoz8Lhdt3jdDMhv5EEFQcEAdObAl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE1NiBTYWx0ZWRfXxbx1J964qAv4
 l+cv4f91vAKXaQKI/nEoY+8e7rli6yxW9Gyb9RfNXcjts+zt0rqkmttAZuUddMguAQ23TQmtvB7
 TTL3TZ2wcKatjDYj2NPkH0LtCTM426FMqUNhCzNTFQt9nAoM7JGNMViY6yRwDaKJHa4hE7PRcju
 jnoSFnJPvvLpteubyaEtQHLvNe4ox+38TOCDMtM4Ye5+Ht1I1MWsSCnj43wvFNUy/iXBe4YIu5h
 qZX/JVzJognQxVb7f9iWV6cQAv5ghx3Pehh6qr+dMVrLOGkC1iToPs7A/loTljy56rq47I/7lRQ
 GnVJBVKyP4c/H60rxta9iAYHQQ5XKJtT2gU/Gev0lLuCUf97WdM2EJr6i58qieU8jxmmsFn7ioN
 3wxaOJEWn/oe6J++UrPc/IP9Nh803CQM23Lc8k5pRScXtF8mHNokBiyAzQoPl10NCjBBHaEqvD5
 tvN/ZxHs/NtORvhA7nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/26/2026 11:11 AM, Linisha wrote:
> Add a note near the start of the introduction explaining that QEMU
> options, properties, and command lines may differ between target
> architectures and machine types. This helps prevent confusion when
> examples shown for one architecture do not work for another, such as
> the pflash0/pflash1 options visible in -machine help on some machines
> but not others.
> 
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Buglink: https://gitlab.com/qemu-project/qemu/-/issues/3254
> Signed-off-by: Linisha <linisha232@gmail.com>
> ---
> 
> v3:
> - Wrap commit message body at 76 characters (Daniel P. Berrangé)
> - Add Reviewed-by: Daniel P. Berrangé
> 
> v2: Take a different approach based on review feedback from Daniel
>     Berrangé and Peter Maydell. Instead of incorrectly claiming
>     pflash0/pflash1 are virt-only (they actually work on x86 pc/q35
>     machines too), add a general note near the start of the introduction
>     about how options, properties, and command lines may differ between
>     target architectures and machine types.
> 
>  docs/system/introduction.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

