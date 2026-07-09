Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E24CC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmDg-0004lr-TC; Thu, 09 Jul 2026 06:43:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmDc-0004dM-Ev
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:43:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmDa-0001cx-CX
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:43:00 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669AOEKd1534477
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 10:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gzzI9NJT1QktBUhM/a/KO3V203xtX5qnWI4uPLcuPaI=; b=L3xrVUy5QpdFWB1g
 TZXI3ac/b30RS+DKXSM0trzLSqIW1xS5VLHNSDa/UqEd+/xpoRlzogiruHDdRIa7
 2e1lR4nFwhM0qNqo5nQNa0Eew/x8w3vERp2TjDCGCdBNSCB/JPBVyGzisMSHEFzg
 9Hbqe+uU/R8cWrv9wW0RYurj8A/pDotdVsbaNNj+YOBWu4iBksZIyHI5Q5PtmFQ+
 WEvmH3FBLnfDVOHPhh3L1TD2KIWzJUWsskoWfJ2ngWsPpeIuHsLcTKf9/8q9qB7C
 wyt9gy9ESbxCzsAlktNf/jLmgURyRA4KgPUWM8V2UOxxgTArl7Kw1uqq8XVovExw
 3gqqdQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6k99q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:42:56 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso34483421cf.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783593776; x=1784198576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gzzI9NJT1QktBUhM/a/KO3V203xtX5qnWI4uPLcuPaI=;
 b=jFRFbFHiAq4Bri4OvrTK+NlYjB8M+BT0H5KL/HcmcQrQkDUX7idRD/00R3F6GljN3A
 5RQPDPWZO0cPEAjBEJzzqbibCfhDZnWYk84AuhqPiUFRbeFXGGXKMHFIzBstr/l4SDQn
 ex0OTiaencSaFamDQunluWFXj4xLQJOvWg7imyYQL+iuCODcQTIOk5x4TUlw+Xoafrf7
 1RTEsb9VQW1JQ7L02EGmUNsvc67+AsqB8v1hsuAIxFWQgG4VOh+jScOsy5gRkMDQlEYX
 0K+niAPQgTCjKPNBP0uMCWReShWO01PGb1W7DcebuxCWxH24JLXRRaBX/hdePLc3GnZg
 hc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593776; x=1784198576;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzzI9NJT1QktBUhM/a/KO3V203xtX5qnWI4uPLcuPaI=;
 b=ENV1pTSTC6xqwl9mQGFMYM5lxVninvIFvVbYB1rj2X7Tz8R7+c+sojaBVId0cZstgG
 nqh2A7Of+M7rNQL8nqy7AiOXOMNdY4MYZ+/r5k3I0cEEpGjWciz7EC/tdVYZj55edy6n
 RtBrrLVF2WM1XTjwrCD2o6lLTOkTscLccWOd3bZhipGrRzqGXcLEIw1ap7hfKCsRkxbT
 j+KO0W+G7NCgGp8KDhS999NbtT6Ni4NpUpefVG/6TnTs005Zta52yUHqSLSJSlBnwqGF
 QUFIdK7mZwDRBuMrHSeLAhtlZhd+m3/SzGDn3n2NcRDd6A6RYVIASS/0iOmh9bDD6vBY
 /acw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoN7qVmUX2kZ0x8oIa5NCG0+rjUu7eFHH2X1BgIimxfKC/CSwNv42J3HZxKcvproCcS7YHe/MPat4oj@nongnu.org
X-Gm-Message-State: AOJu0YzgGwsc1+jA4iRMvY0jrkMvxsu8QjsTJzk7vmyqaKh1hyIM+onf
 8+FwHVaKv3P5DW4ED8x8WjMbwxV4H4KkLgfdGOt7x9hLBu+JqDqpPIouJVUMIvA5/NBrSSnOUyB
 j5rPY2RTwmSMUUrmu8JBosksuPhMCVeWs0Ok5a3kdNZIrQbKnci1Qay9Vgg==
X-Gm-Gg: AfdE7cnquAZ34emfSwAK0awPWddUviIQs1FfJzPTB11mrC5NMRb14WjGhSUQNWkgQNo
 VDRqr7HtOycE9Ooe08ZaF2ZM7rPByoUpqSOOnPzoxJ24pw3f/Ep/LFLi2WC7iKuqP16eKYBbLDH
 B0boSgl8xtNY5H2d2nmtOLfEahiyj6pXNgF3uz1w/l+DhWJFATW5exEMC1sf19Sp+wcaTNRj+b5
 02+71IE14UeiZvlT0Grgzj7vYtkMNSr75FDcJ95aBZvcYUh8BweYc0zxfTTQyqn+DRAPuZbc3wm
 KvP7Iaui9zds5ReOe+Y0pCA6IBrllQR2J+SR/vjBO4x9vDK4LGJaqjg3GTQcGtYga68hdnX8NrM
 fr3YPaNkAvwhJ6XOuZbw8dnamYFWhQN5ekS3T2E0S8dRGBYW8KojsImh8vMbMaA==
X-Received: by 2002:a05:622a:1aa4:b0:51c:439c:babe with SMTP id
 d75a77b69052e-51c8b3db19bmr69728841cf.29.1783593776362; 
 Thu, 09 Jul 2026 03:42:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1aa4:b0:51c:439c:babe with SMTP id
 d75a77b69052e-51c8b3db19bmr69728581cf.29.1783593775898; 
 Thu, 09 Jul 2026 03:42:55 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm53039222f8f.2.2026.07.09.03.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 03:42:55 -0700 (PDT)
Message-ID: <892edfa1-e26c-4185-a915-079bd2887748@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:42:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] scripts/gitdm: migrate from contrib
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
 <20260709080040.4157324-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260709080040.4157324-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwMiBTYWx0ZWRfX/2vWagTURgm5
 ehfdsZgVP61nDrYMI3uWGT/cNMBsFdRNgj59rsB7464ABPOKLVTMLBU1AASAn1Px2H2GFjksTRH
 lTQtbb1f0gA+4UQ9fTxP6arkQH3hnJs=
X-Proofpoint-GUID: aiCqGVIzZXpKR5WBQ7gZPLXxAZdoVetu
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f7b30 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=JgGFZziSFi4rzet4RtMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aiCqGVIzZXpKR5WBQ7gZPLXxAZdoVetu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwMiBTYWx0ZWRfXwvyI66xGIaRT
 ju1anTg3zzKe/G8ltDx5fO6CwDV2F2fUaHGgR289tU4su7Piud2b9zBmgGbxvy+SvNiHRQ4+2iw
 +pRLHVqppS+6zEfkjrqZC5Z+Rd6ffv87wXmlorDLeYA/YyG16LIFOZuhcvDmSBlJZwaUproijXV
 iZrzUpt+bes7uVP6eJ64whD9Z95d6EeIniHrSHUqanBFE+rSrFXze9d55D8riS+CjBDF5Ihxrl+
 i23aa7zwqELZaLpoMYdHh6ie3V0C0AA1DFcAS3tSzXOHjx1ud+EdrjYReVxsA3q1zLAmEEhnQpV
 mkUvZ6D3LqTCPP2p3C6SFbAJc2BDd9kI4RFeih2wUpEooyNe4ZSOJMWIPu5jUDsDJSOIX9Ejffk
 j/XI1oxQ0PfN6zo27x+ct5bZa41PZG5J85+olhBt1wUqyoD81Fo6K+33X7naYJB/RFeZhF/cGiI
 G1NQC2U43NFX1IimZlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090102
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 9/7/26 10:00, Alex BennÃ©e wrote:
> As discussed previously it was suggested scripts might be a better
> location for this meta data.
> 
> Link: https://lore.kernel.org/all/CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com/
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gitdm.config                                  | 40 +++++++++----------
>   {contrib => scripts}/gitdm/aliases            |  0
>   {contrib => scripts}/gitdm/domain-map         |  0
>   {contrib => scripts}/gitdm/filetypes.txt      |  0
>   .../gitdm/group-map-academics                 |  0
>   {contrib => scripts}/gitdm/group-map-alibaba  |  0
>   {contrib => scripts}/gitdm/group-map-amd      |  0
>   {contrib => scripts}/gitdm/group-map-cadence  |  0
>   .../gitdm/group-map-codeweavers               |  0
>   {contrib => scripts}/gitdm/group-map-facebook |  0
>   {contrib => scripts}/gitdm/group-map-huawei   |  0
>   {contrib => scripts}/gitdm/group-map-ibm      |  0
>   .../gitdm/group-map-individuals               |  0
>   {contrib => scripts}/gitdm/group-map-interns  |  0
>   .../gitdm/group-map-janustech                 |  0
>   .../gitdm/group-map-microsoft                 |  0
>   {contrib => scripts}/gitdm/group-map-netflix  |  0
>   {contrib => scripts}/gitdm/group-map-redhat   |  0
>   {contrib => scripts}/gitdm/group-map-robots   |  0
>   {contrib => scripts}/gitdm/group-map-sifive   |  0
>   {contrib => scripts}/gitdm/group-map-wavecomp |  0
>   21 files changed, 20 insertions(+), 20 deletions(-)
>   rename {contrib => scripts}/gitdm/aliases (100%)
>   rename {contrib => scripts}/gitdm/domain-map (100%)
>   rename {contrib => scripts}/gitdm/filetypes.txt (100%)
>   rename {contrib => scripts}/gitdm/group-map-academics (100%)
>   rename {contrib => scripts}/gitdm/group-map-alibaba (100%)
>   rename {contrib => scripts}/gitdm/group-map-amd (100%)
>   rename {contrib => scripts}/gitdm/group-map-cadence (100%)
>   rename {contrib => scripts}/gitdm/group-map-codeweavers (100%)
>   rename {contrib => scripts}/gitdm/group-map-facebook (100%)
>   rename {contrib => scripts}/gitdm/group-map-huawei (100%)
>   rename {contrib => scripts}/gitdm/group-map-ibm (100%)
>   rename {contrib => scripts}/gitdm/group-map-individuals (100%)
>   rename {contrib => scripts}/gitdm/group-map-interns (100%)
>   rename {contrib => scripts}/gitdm/group-map-janustech (100%)
>   rename {contrib => scripts}/gitdm/group-map-microsoft (100%)
>   rename {contrib => scripts}/gitdm/group-map-netflix (100%)
>   rename {contrib => scripts}/gitdm/group-map-redhat (100%)
>   rename {contrib => scripts}/gitdm/group-map-robots (100%)
>   rename {contrib => scripts}/gitdm/group-map-sifive (100%)
>   rename {contrib => scripts}/gitdm/group-map-wavecomp (100%)

Squashing:

-- >8 --
diff --git a/MAINTAINERS b/MAINTAINERS
index 6171cc74940..eb915919d76 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4615,3 +4615,3 @@ S: Odd Fixes
  F: gitdm.config
-F: contrib/gitdm/*
+F: scripts/gitdm/*

---

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

