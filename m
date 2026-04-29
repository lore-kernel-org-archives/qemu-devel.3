Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD53FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 22:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIDTo-0002sA-Lr; Wed, 29 Apr 2026 18:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDTm-0002rY-WF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:34:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIDTl-0008JF-EH
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 18:34:02 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TMFBMK3885247
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RWccqpjwD9CnKlm3ht8XXR8KTMuRoDGKGHWf17FFrfo=; b=bsWlOkNK6TdBYnfA
 70L5ggZl10dL3xImRAZnw0hJSrLhnVtyFm9KkiyTZZDjwQfnLxFIvGR0DKINSQ4Z
 /vfQtTEGzDGV1d06JghAF+i7l+9OoDruLTszkNUz3fcd1/HixxkKUoARIWIWp7MD
 /8N/V/CgGkYAzO029ckcPHozxpcpLeyXxu0mJE+wlJoY3uyMTyc4TQ5M5oS9a4I3
 GWqq0CCywdDrEbVm602yvj1yBKy3h7dGDE0FJFOpnZvDDHH+rahiBnVQEyXGH0VT
 ujG41JK9t55A95uuP8iAY2KHoAGkIoDDkxvUy/iqiZS0bctYCfxs7t7LXintrTnR
 09WwxA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dutmag1hr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:33:59 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2cc75e79b97so633073eec.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 15:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777502039; x=1778106839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWccqpjwD9CnKlm3ht8XXR8KTMuRoDGKGHWf17FFrfo=;
 b=XCI7tbuLwKnCaWxeJ7gw4B5Gntw68TxEjlcc/OXjRtewoGXJlE59KeUStXHFqzE7p2
 PtC8UxFG77HqtHfQVnpBda6AehzKYBMPdN1Uz0nN4kw7t/pqFwFbh+Dk78dugKSytRFd
 g67CrXhLAkXErQUPE0uD+zelIlbOqh+ysLU3UMpkEiIT6MQJo+kQoit+lYqtReeu6YUV
 1gf2LnlgFDAR2FAOXygWxFrtJZtM6rt8PIbw4i1ATQnXmI7hGzfHmXe8/Pxk1AdFWvul
 8dDwavt2JR/AdBv4vv1TBabGtFS40gVvRtJu9PxZj0V/zfH2Z84U2ChdH7GJkNnxdLmT
 Fdew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777502039; x=1778106839;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RWccqpjwD9CnKlm3ht8XXR8KTMuRoDGKGHWf17FFrfo=;
 b=dTnF/VPFO+B5eHqJYi9HwaYqwWpZGCzBaB0NSYBIl+Ojv/10pmM6P+FKd16do+x2bx
 VrpIFSOMPnEVCRQ+p87I6ZDzTFZFaw2v6clta5/N//VNfnp99SSa/dZ5cnFKVeFV6ogH
 ZjbRShLaBYWgG/ZpB6asJ+GJS4sM5qv5Bofk3X6cBzH02rF3D1VN5I5xwqo+4aEulUDq
 WG0M4JyfygyH1UMu9JlccU2pLYKPll+lhunz0gMLbWzSpIOgTD+slI7LDzt5XM1ZK3Kz
 MZDNG65xbbPFLSJhr/nJD8TG/4oOyzL0C4bbybp/DF6594TTL8S3Yfk62erW5xqeo8H0
 ruug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iSklNUkG6QdJpsPcAhEw5boZRC6X2bJF99UCLxC7AuMPWjngpOFBh0mRwUBL1K50JwhT5fSul1yfl@nongnu.org
X-Gm-Message-State: AOJu0Yx1He4SO9bw8aW5jUJYeDro2++ItsIZoT6w16WOESeBxlTnF3Lw
 WbB4NU/WLeTyeLo3AnkAS/mZ/7VMOaIr9HIiq5hcFHW8nJGLQUc4TWeDdDKBcpYoDodCd0/SSY/
 DZ0eagi64mpPiEFLTFlm4PQst7B8RpzobO4j7Z9agn/qyO8mnggj4OvLBQQ==
X-Gm-Gg: AeBDieu83kPZxi7Q5YgSZZ3zSr4f0YwEU86P/d31KOlJBNgkoFF6+rD6zQ7aBNlzok3
 Xckpccgvc+BM34ZxJTOw0YHMI2/81rIqu4U3b65zvlk8n+8c4yGEJVDGA/7Am1VqpRFynN+KdY1
 yLu9vgaN9SOstOIsmD6uHrUfomf7pXVYQHg8PCLV3eejMK8rSRr/L6Y0GTKooqqJdv7Y4/FLJy1
 vAZq+ml9y8WwZTbcZIfsPEkTcFvxc2X6o0VDdmv0ZicFywa6zXtS1h2KG20nmO2L5oVB998SZAt
 1uaA8qUg0YqnPPVBqGEPRdTPJfFp39d9zlhVroSM+IGCIHhVsK09hawKjMnpF+ZtV/DLD8yWA8p
 FDWzgR1q6m5oohacyGDjFaUzx6bSImP8lq3Bkmv0voI2sZe6cb+PDYV7ltphrQZb+lcx+DMs+7/
 M3mTjZPgMRPJRmk+jvuRvQS0ez
X-Received: by 2002:a05:7300:e827:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-2ed3ba134a7mr122448eec.4.1777502039261; 
 Wed, 29 Apr 2026 15:33:59 -0700 (PDT)
X-Received: by 2002:a05:7300:e827:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-2ed3ba134a7mr122437eec.4.1777502038754; 
 Wed, 29 Apr 2026 15:33:58 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1c070beesm4224092eec.14.2026.04.29.15.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2026 15:33:58 -0700 (PDT)
Message-ID: <8d05d0b9-bd92-4d7f-8b55-ce6f1f3f129e@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:33:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] bsd-user: Switch to generated syscall_nr.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260429-syscall-nr-v2-0-67a8d09dc13e@bsdimp.com>
 <20260429-syscall-nr-v2-4-67a8d09dc13e@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260429-syscall-nr-v2-4-67a8d09dc13e@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 9phVT72ATQJvyymSDcUounHi4oNa_p95
X-Proofpoint-GUID: 9phVT72ATQJvyymSDcUounHi4oNa_p95
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDIyNiBTYWx0ZWRfX2a5yEQuAGfV3
 rGZesJXe3cLraTSG8EgzIkj+2y5Rd4ka6xkK6MBkLQUx0jfxJe5b2Uoiek6xhGo7eI3znnPpXyk
 6DiRTtRIvfg7yeQZYU8RGqK0OnRYj05ODlvvmA/nEySG505OnmEYBN2IsJrgX5XXQHLXrzoZhm/
 XPlLrSUhaX4jRCm9xA/PKEd7qvJaM6QIUkfCTlDZBN3OitK5HlvusF7jSN9gKoROmMQORuFxVBA
 SWbLXHL4zqRErXXfEOBPLfTRDsBmcJG/VV93d5HQy1ZORtk2CaNA7tb99I97ufvyJ0F3Sr12lHq
 S3kMAtfCKmT1HU2RTHi6XZOYnXkVqbqCkCUygwGNosyuo/CxlKFBayBtDNyEfTBxH2gm6NsX0a5
 PxsFZvSSF3HdAkgzWp1o1euvSLpBHyw/s1AxD5U1E5nknZ/3T1CPrQX/2QRCAVL/JwEWxs8c8Gd
 lu4XyRVE5iMtfjxVkMA==
X-Authority-Analysis: v=2.4 cv=Fpo1OWrq c=1 sm=1 tr=0 ts=69f28757 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=7Qk2ozbKAAAA:8 a=EUspDBNiAAAA:8 a=8cUHYrWBstQ38jQydEoA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_02,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290226
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 4/29/2026 7:38 AM, Warner Losh wrote:
> Now that this will build and work, remove the old syscall_nr.h and
> switch the include over to the generated file in syscall_defs.h.
> 
> To do this, I had to delete the old, wrong definition of time_t for
> FreeBSD on amd64 since it stumbled over the fact that TARGET_i386 is
> defined for both 32-bit and 64-bit builds (the new os-syscall.h had the
> rigth definition). Rather than modify this file twice to fix it, rolled
> the fix into using os-syscall.h since it's still easy enough to review.
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>  bsd-user/freebsd/syscall_nr.h | 515 ------------------------------------------
>  bsd-user/syscall_defs.h       |  18 +-
>  2 files changed, 1 insertion(+), 532 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

