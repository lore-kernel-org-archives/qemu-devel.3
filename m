Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE9F606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sz9qJNtl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yr0W4a2V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIv23-0003tj-73; Mon, 19 Oct 2026 17:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv21-0003s6-Qd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:36:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIv20-0007B8-5u
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:36:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZN2p3070775
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:36:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cc/47SoofwtPnJGK6jWnX/TRHH05JDV+k10VMYZR6mM=; b=Sz9qJNtlORFviO6K
 pVvjfbh8kOpHHeDYuScBRTnV5zEzaTfSR/K4piv14NSloa4hr8uZNzx6wMpgP3A/
 NWkfFVQXY65Ydmvf1BtOfP2h1fX/N+1TNOnW8ImhRdfRRlXmFriMKeq9b5Q4u7vo
 5ak8MZgTnCnFHfp8PBb6hKax/Bq5HDiegajKPebjqebGGDNrUjBwsv+CcjrcOw6y
 RRAScriOfthsCX7/aSj0dpTdmV7Uqq0TKYIKYnLODAMgcl5UGT7CbPwZnhEE8mSc
 9NozKmbkJ8jyD3e0AhJiJKq5rkUAiuSxtGLBYPx7s2HcTAqnt5v+pUZx3z6mgqq5
 a4VLRw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdr3p0seu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:36:30 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so8125835eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445790; x=1793050590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cc/47SoofwtPnJGK6jWnX/TRHH05JDV+k10VMYZR6mM=;
 b=Yr0W4a2V5ZkoRKGE7uP2FCWyADCvO141OREXhVKk26chSZXkWfN9CbSNxhEpSpGUsy
 yiFFhksGsQG636PXhCuLq5o847Xti08zZjmPrr7w9ssmRFKB7lIM0S0fom9iXZnFoKcA
 4497UQqShxPuZHXDqztaGIryXn0VBV4DYRjyiG5TB9qkjvj9cpheUudS0HD6c63l2gf7
 ehND8aTecR1oI/DiHNESopDa98npEHKZs/eKTP93jS3mGKlK6d4rZU9BPEylY5W7u6au
 3G1jACWK2JjT3LCShqolmCL86zrIVyLCwbv2NeHJErLWN3AZdjHcvGA8jRPHyfKISw32
 OI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445790; x=1793050590;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cc/47SoofwtPnJGK6jWnX/TRHH05JDV+k10VMYZR6mM=;
 b=IUCY9AILJdDJ3SBYNEbKFA65dpc6Fsl7jVZlUhkeJcbSyNApmDqDUDDRcTP+cjPBMl
 V9MjlP9khlTWIWyXS8f47YELLtk/umGF12hbksC8VIxs1PRV3+36+B8hzjgm/aunAiG6
 5cMnWfTTi5PNwPg0AbqkaiPeElDBv1MmbLAfbVjGE4RhKbGnqU9EXdsjU8NeRiqXtWLd
 P6QOhNf3Xo9pEP+1F4I6tK5Qodu4CZfpkNeeJvAYEPouBncBAf6SglA9SbscHPT+bygU
 y/YjoNFQ2hSKCYR7TkdPIctZ7pqRr9RwOg74u+66jlRCZrk0KLPSEEyFSwEf+RYPOp0X
 qs3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByvXGzhO0mbFpuOYIUodQNzvHkuKQm6nDGHxIeHKElLAbbpWOcfu4bePp/YVxEAVoHHFmPXUxBpI78I@nongnu.org
X-Gm-Message-State: AFq9FYLgoNM1YuvrUEfKp/45Yt8VtvbhSz7QSh0qhFzgdk++1zaKTrtl
 ECn14kWzXu3uGbufY2FP3gTBrQDdubd1ma4QIcBNqId5CVvJpQ90SHVrNTB3jQJQXvQ60LYKX3r
 Qx+5MKSQlC7raVJGIMvHi2WwI3k+Uzln94qGS+dsdqhlkDQsK8SIsYvzsc4djdHavuA==
X-Gm-Gg: AYBFou1wawbkY/llleGg2ndV6mcYAuSLhq+1KQX5IPrbSPwHLf98a4qg1CYxP5v9Owl
 0fKxekJsJESPYCXAkgi1ZmE//bn30r22Wp2JjpzbHtJgF966jSimZeNl0HmYBhu4MJ32EFeSCBa
 1dalRxfVMaQMwbKlqWXOduqDsywhDkDSQdOO81jGG1dEMIB9RZqVzAjeW+2xXhYZFTmnsD4WiFs
 LO8gSP2oPL8W5EG1eT/pGlMkGDpMVc8PCFuPwAPgSFlgcQSkx3zlG4zkULZtRTM0aBSLeQJ7V+P
 +tqJHj58XF13zIRcYu6GcDKhzFSSH5s+8PKucmNP6t9CWOI6Oi4o4T0LXWVex90YNEEsXTehYK5
 LbzwW76l9F7pZVrH5jLQsMo7FqPPVXeerJCr3hCHLWwDjXEezmByUTh619zgLMSFzEZ9UJA==
X-Received: by 2002:a05:7301:2a9b:b0:351:7f5c:dbe1 with SMTP id
 5a478bee46e88-361a2b3e483mr12088026eec.28.1792445790043; 
 Mon, 19 Oct 2026 14:36:30 -0700 (PDT)
X-Received: by 2002:a05:7301:2a9b:b0:351:7f5c:dbe1 with SMTP id
 5a478bee46e88-361a2b3e483mr12087995eec.28.1792445789477; 
 Mon, 19 Oct 2026 14:36:29 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608258aa66sm43777319eec.20.2026.10.19.14.36.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 14:36:29 -0700 (PDT)
Message-ID: <69db5a85-b8b6-43ab-ab1c-bccd54d29ab3@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 14:36:28 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/hexagon: drop a pending HALT when resuming
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261019060911.1479329-1-brian.cain@oss.qualcomm.com>
 <20261019060911.1479329-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019060911.1479329-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: W1KbGZGGaaiIiDF5AaAt5o6dUvsZ3OGI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX9SMihKvaq90o
 iw4KwWe7i5KDUp1i8zXzBtHi0NM2i0h2GqqjbITz7WxgTswjf+wQsakB5ezQuOSlSETj9copalu
 PM/DyvcnuaM8OPx2E+ClvRl34H41Vt/aYlzsMr/Gy2sytHlMvf0hrW3nmBgZ825lMRqujX1etJw
 kgwSp1FRGb9nLCJ4bivQe1HBZkSvIuw3ZjWjjMA+s50+WFu5lsHmRuFu5U2q1ytFaqoywibn888
 n3JbHXuD/3GHAGVb9v7FWNUAD2BNPNGbwM4peFLHR5OPufaZUH4JpZl2AGASp4M6NGxPl+92ugw
 F1re3vwB6mJ3j2t44Ztqw71gwMtjrrrmZOPzRARO3i94GgPZUMi0pSy1Ifd+0JMou5bhmdxxZ2A
 XOaMcbjbf5Q63bofKG7N7Hlne0pLwAqlLITAovsktQ6il1K9gaf6G+SvUqUde+5pb06HvuEXMhO
 Z/So1qqfIEDPMs2PiPQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NiBTYWx0ZWRfX6EXLgFJxwxl7
 7AlkV70wL8CBCIvn8ShRdZfTQ6fROt7+UE1Jps95Q5xJDB3uIMzdgtLO+HTA8rqzqem74MUAZ0T
 rTM2zUWzKylNvSLoWpL9wfIqysdjowc=
X-Authority-Analysis: v=2.4 cv=HLxWhYtv c=1 sm=1 tr=0 ts=6ad68d5e cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=UIrKW2u70rMBb4VZzXUA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: W1KbGZGGaaiIiDF5AaAt5o6dUvsZ3OGI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190086
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/18/2026 11:09 PM, Brian Cain wrote:
> A thread entering wait mode raises CPU_INTERRUPT_HALT on itself and only
> takes it once its TB ends.  If another thread resumes it in between, the
> HALT is still pending.
> 
> Clear the HALT on resume.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu_helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

