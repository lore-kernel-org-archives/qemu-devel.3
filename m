Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0C3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TCkXms9m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gpCGiP+F
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV6R-00009w-8g; Sat, 24 Oct 2026 02:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV6E-0008Rt-PD
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:19:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV6A-0004hP-KC
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:19:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O4lfgk3959972
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rqZN2WhzYiF5Kfr65xYxHPnXB87OFaCyBi7F5OcHn7Y=; b=TCkXms9mjvnIxrUQ
 8HxUbv6yvEyoBBdNyjG6B82jjO69WC4u7jMDC8rB5z1vaakYBli/spWpzBgpb3pW
 /NphSbwpIGGNLVKcmJYzhBbCFyUQs+WqrBjOkgn9DmpjEecBP292kfsnAVMvm5pM
 Oy4nb9olpRo0Wf1hDT228s6Ld5SwcXfZGBnQ3IkFrTVM8RI8HqceaJWl+jkUL8YS
 rlb9SbggEerz2uKxr1k7qebeW68QgwKiFvYE2ennFcnsHu04VJXpTSti30unU0eQ
 EiN1HkHN9NMo/P2wY8wSm1asbq3zCHlw39C7kwQxkHRf/mXe/gQryeya1Va8D5be
 TrPTkg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgny9r5bs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:19:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e9821ca96fso17123065ad.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822759; x=1793427559; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rqZN2WhzYiF5Kfr65xYxHPnXB87OFaCyBi7F5OcHn7Y=;
 b=gpCGiP+Fz39+vmnT6xvhsrk8HyPb57JpPABUU4LHK/2eOLbfhuPO1iZdYEfnHX4dEJ
 ITuG9+2aPz3nL9FRj2kElHr0LAbOSfEXDuesEjQXWukf6JRDkmoUPqMmu/Z9aGslPJIM
 wiRm9UVkLT6viimR2Kp1JJyozK5ljWzSrNFw2Oi41jG89rFupsKNx9ARm8l53OpU9qow
 fEa2DGCFVOyr8zRhg21CUWMVB3DdP0trJPSzciz/KEi3ywnUoUGQm+RC3R5GGPdQWw6+
 VfrL3rAgReNinsR9KtKtbck+AzLwdIsL7sASB1QxglkhorYLqEnC2DgdlTNMbiAH08dP
 edhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822759; x=1793427559;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rqZN2WhzYiF5Kfr65xYxHPnXB87OFaCyBi7F5OcHn7Y=;
 b=m3p1HNiTRtV9g70QEM0+WGbDzJ8gNL/hWE5Ry1F7/k9Ax/w68vO1eyky2X8ZcKDDl1
 RjkHq836SCyorult3kt23qr0bVXw7A3s+ds+ne4/fm7Gbf/CTCkFJ9DQ9wM832ug3Bwh
 BE1UxBYPoAjk5Vy+Ev/pIz13lBq9C5LPgGijcN1ixXLTN8KD3o/+AmbQCMeE1RxVzasY
 2Brh/WbzHIWWpifxJM6kpAqtDCMfWxATYwEPlE+dU8uaGCBUydJBn5aG1C9nYIkBYvN8
 o+ZUiuyId5Gr4tBDpL9pSwNv8ZfWtqaH7XhckqahmTCl+6wggSwjgrbBvtSKdVReocLt
 UC7w==
X-Gm-Message-State: AFq9FYIg5uizrcKe1RBVY5tOSxGiyqmCOVDuk2zWwaXACAZ5F4YYrTgK
 QMd924gy/T484WHP4fgcb9IwbEdIXfkjuk0pqHeL+dc4yZPCEg+tK0pH6vF9xadrad9b8WBTV39
 1k8+2cLQ3MIJ85ToCgJYJXWM0ettZ04BEhvmkXW31xljKBWuBgM467wa6G+Ht835dXg==
X-Gm-Gg: AYBFou19afqfWSpqo9tklMl0gjEOKvG2wzW62FgqzwHqAXIICxaLWxSnWciSAKUnmwr
 FmmJWA7P50XA6mgKHtFKBkcoifERxzJ/0d8UStRnuBQy20z7XeoaeomS1AkEPzXhmUp/XcjXN0N
 sd2Z/f4BblTdbiCybzRBrzgK1+VInJphHX0g+Dw4OcwwGycDSHi0Ag3ohUXK8jCK7sOFNDcVih4
 FQ+pQGvIVZWU9dy7K79VHUrKXBeAE9cj4PdJ0Z541jA8boy04guGSGQJfbbWUCsMH2obYxpb7ca
 mYB1ingzFDwT0iMsIQPhGZv0lojnrtz5855DNB44JnqU6EqgmE7wFHNb6L81OBeeYW+VhxnUcAZ
 HF+/4r5rwsDf6WCh3xkz6IATCnpzaJeBOK83XrtMD6/AW9tQuVr2uSH45
X-Received: by 2002:a17:902:cecb:b0:2ea:778e:8650 with SMTP id
 d9443c01a7336-2ea9c6690f1mr10238295ad.14.1792822759425; 
 Fri, 23 Oct 2026 23:19:19 -0700 (PDT)
X-Received: by 2002:a17:902:cecb:b0:2ea:778e:8650 with SMTP id
 d9443c01a7336-2ea9c6690f1mr10238235ad.14.1792822758925; 
 Fri, 23 Oct 2026 23:19:18 -0700 (PDT)
Received: from [192.168.1.169] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ea9b1ec180sm2892325ad.69.2026.10.23.23.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 23:19:17 -0700 (PDT)
Message-ID: <4429d049-3e49-4e5c-891b-c07603606cea@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 23:19:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] multi-target: add riscv64-softmmu
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: oyd8SCTFaQXdaE1AQtKNesZs-7x0nvTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX8aeHnphqcSJV
 bbLDI1JPkT6rZlytBQW1bR0eOUSTIQ9EDOZ1x5zjbAFPrTdnhkahP1oA20a+Osq0HQBYH/wybo7
 VNuK5Z0Ph+JMBhlABJ6qNgXHLr1uL9QgbJ2Bl7bjNgbTK22i8FwT9gBVD4S7Z1NK6psxNKrgWIb
 jsl4vEayfnI+tlbrdfitOjRo6RhNkTQbMwDHXbwLGNY20lFT34b2nWcGkiTHJK8kpO5OJXXHt8k
 DJnFb8ijCWEZrEInomo9ao4tIKpD+kmq2AkGEKcfXlrs5LC4QqeesXwdkiuCeBjvgh4awzwb5bp
 fiY0C0VPiy2K482N82RRKdr4wvvqtBbHCv9yZ4DMhKmwHGAX7RmejbEGlfHvQyxEHp9wo/ByVio
 MaccR/ArU2vKEsvNJfkT2Wh4N6XTxRvd0MaMXT/d5Rsq/rFyHh1a+FlWqdAJ+8J6fGObfp1CBEJ
 N11taLJGcaDB9pLF9jw==
X-Authority-Analysis: v=2.4 cv=PqcG/AM3 c=1 sm=1 tr=0 ts=6adc4de8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=cr9hvFDl_NCMqBCNp8IA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: oyd8SCTFaQXdaE1AQtKNesZs-7x0nvTj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX85mRKLn9x5Kf
 3JA6v98CxxY61mF3i3iSpW3XkB4e4IMzjSFN6CCWJMEORZjbt/XqFNyPJvm8yACDsZ6tpMOSiv1
 qF607m+IuDdvIdPLfxLKQxh9t+zgEQk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Only patch 7 is missing review.

Regards,
Pierrick

