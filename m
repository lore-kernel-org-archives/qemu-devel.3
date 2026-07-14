Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54482C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjaCf-0001BT-OB; Tue, 14 Jul 2026 06:17:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjaCd-0001BH-3G
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:17:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjaCb-00074N-Lj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:17:26 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SN8D3718197
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CihF7AAalex
 acJXlj/FoPODvQt2iNKawINOE90WgNzU=; b=OCqJdE3BTPCfNwP65WSd9c+rOS3
 OgQ2mM8NVUqgWbqI7Sjhvp2j0XJATk/t3G0ZwIDJzNFZ8xDOVQDuAn91R8X+MwE1
 OA+MtJjqvI+8jto97GMsx/da1chT7nQl1uWoZjzxS/l2L51V7L74WMX/WNd3qZ6c
 xX2J1sk4iPVsg1a9HVRd8RlDFkAgra73SqfbG+6ehVxYm0fzu3fj6z68zNPA9qaD
 xII5DtYMg+NtsHnd+o0WDY8xmf5Narm3nxNLvKo9InvUpC/K9BAkqszFMl0L7ocq
 4ji76bYi8Z37GwH2fIXXEkiaZCIyYR/FRHBTb6fh3R3cFJ5+ctT1E7Oi7FQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd7gvjen9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:17:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so1366054a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784024242; x=1784629042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CihF7AAalexacJXlj/FoPODvQt2iNKawINOE90WgNzU=;
 b=aswb84mnCaJFM4XcjLSHFRJu6yZagAGxVi0GEWSS1bKRuAZRy/VjDHRt75gEY5fcHP
 IC3XpC+Jb6zXqbPeIXDDjGQ1jnI8YQULH+V9bc/TPmKJyG4fo6uefwzz3kfiz4/mwOAW
 BBwyzoNhY5QkfVe6oO3NHsNg+qk2QalkJJxhvyHSx0ti6vg9HdYONT2tTeqQkQ1Ml1Qh
 hnboPYO+/cLw02Kkn9tAZiwygX0vLxou75J2lrKocMEgS1GuN2AGMHRGJEWZ68Zjd9s2
 Vnh1nMgEiKIogfhC6kA/1FL09F8cJTsVs8YfR+zKsaJ+tDHXy2rdy6kmE9j+A2+S6P1h
 mMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784024242; x=1784629042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CihF7AAalexacJXlj/FoPODvQt2iNKawINOE90WgNzU=;
 b=WXrkhubCzmTj00zBItTOSseGpL1v4gOwP46l2+4dRQEZ+ooIfUYqwxtmlGo5SiImc4
 hVT6/Rh7zHsxEQfORI+3kfxFZx5vmqUW4bOl27nl9JYRGfW60raolQmq7sE2wwnfnQ7Z
 bnMpObI1hUDLRGEQFTJwKmlntKoS7EGO4N/qHG8EMDsP1DubtjH0azU0C6D7P/OkLhyP
 RpevzYo+peeVDYrzJxFOsp9KmhIgpUAi0Ag6voCw4sR0ToIZoeNW9EQzoD6vLgeyP4kw
 WbOcLDrcLrmxdWDpxnIcYW+AaDMSF/zsyyK0ux3tmuFfWuZaIKkS6sN8sHYle48l5FZg
 cT/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roe+eq3ii7MCosyrtsaF/75t1raEwtH/VhBngZHAxQ1cQM60g7kCJ7AsGdE4r8CyS67JRhJD/URXlxk@nongnu.org
X-Gm-Message-State: AOJu0YxMANqQo5XN1+QYcIDvrtU+w94r4B9rgQpP32RtSydK7/XoKYm7
 AgDguzCriWgWYYC4RRZrc92T/6t+vjuoW7HqHFSZScAzdnndW6W+APN00gFDwdqBiDfom8cVAQk
 bSmalGPfrXdJQ5YRVhvSNdOMTkNhPcBaY2PzyQ7r3rSQpzblEstn7piAOiQ==
X-Gm-Gg: AfdE7clU6BlhUAyleVqGWnJUYmOcDqkMMtnvzfhAn+pc7baSEQRECt++zkeyzUu20HU
 QZhV9LsjbJLiATNb+G5xntfvTx2/ryeiwKlF3svACNZMPr5slhFZ40clam3ksXwEbXWXE1XAJ5X
 ReXBn+AAYmzDy2noZv/Hhb0ujiNf6W+IVKaJfy+5Gaw3ih8lfET0x6tXD1Yqt0/M/sN8E8LWGHl
 d/Kmy+NLiAlKBVyo86nXEewICEoZ+HuUaqxoxUzBW0hSGyN5bEg1oQskoCLXM6PtGxLlb6YZJNq
 OuLHCRv2sY51AXwHxR8YyfU2Vk5snJflGCBsQ+U69MXWAi/zVzhZlA/KQRaKSf0/P36okdLo3of
 Q2pkpkmlptNh12eVyPcWq7MonYRxz69cs7NJ1d1EqBislUW8kN/sWVsloRI7cVB+dmzrpujxH1w
 ==
X-Received: by 2002:a05:6a20:244b:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c0f0b9158emr20111127637.29.1784024242032; 
 Tue, 14 Jul 2026 03:17:22 -0700 (PDT)
X-Received: by 2002:a05:6a20:244b:b0:3a0:c246:bb98 with SMTP id
 adf61e73a8af0-3c0f0b9158emr20111090637.29.1784024241549; 
 Tue, 14 Jul 2026 03:17:21 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118389d9bcsm67727748eec.20.2026.07.14.03.17.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:17:21 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: pierrick.bouvier@oss.qualcomm.com
Cc: matheus.bernardino@oss.qualcomm.com, qemu-devel@nongnu.org,
 brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng, quic_mathbern@quicinc.com
Subject: Re: [PATCH 03/14] target/hexagon: add aux functions for guest mem
 load/store
Date: Tue, 14 Jul 2026 03:17:19 -0700
Message-Id: <20260714101719.615195-1-matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <c39fe476-7c99-4d0f-9c82-6951264ffb79@oss.qualcomm.com>
References: <c39fe476-7c99-4d0f-9c82-6951264ffb79@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfXzlagIN2PlBjz
 L3LbtjlnG/daxpiTPlTR9h3TnOiXVEg4714HvkMuk7RGkGn1rsPOMZaVjtyfpFQKqmM4A1P/a7d
 wsjRfNMqht6ztgywHeJ/F6xseR8cywA7k4UeB1m7t03aFD0kTU4KzST85RCGADA3Zp4cwHEDeAZ
 ejnJGo7bh4rKgoJPfvkAAneYtBhSBF70T61hTJJgW2F41/8JAyi4Y3itF6APY7kAWv91dcvKb7H
 f5bDpEUZYRvWuDB8j4H44JLVvvIluhJR7m/IzEbvXDLF4jivti+7qhhLn3rf7ANTO8jvFADGzWn
 DFEED/njlMBkjgTXnYe2Wu5wJvqMB1rZNmfZaZvzWJr52MFXPvECdCxGBMg1bdqP1yzLqoMRnhw
 7lZ+rZpnhW+XsK63UaP01G90U5qDxOCkAeEN6xQsg/M4q+ELumHgGWN2VHTkMmtAACJKnbyO8oq
 +g1jjoDYiR7HDUdjTbg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNiBTYWx0ZWRfX33qvjE1iZ58O
 BFApV7BSYeJ6B1C1kC/aNtx+o6BOnp3oHSRW2gO+7OLRm/CXr/WDOfwR+k2GCg6q3GJWjv1gypa
 9QXzR5EI8SZLgkmjJjy0doFysRxi4Ko=
X-Proofpoint-GUID: vsfl7IHwfTAop1uEf1t4Ekv7AQszOIjV
X-Proofpoint-ORIG-GUID: vsfl7IHwfTAop1uEf1t4Ekv7AQszOIjV
X-Authority-Analysis: v=2.4 cv=NYjWEWD4 c=1 sm=1 tr=0 ts=6a560cb2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EhmUPj8qQb26cyimsxIA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140106
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

On Mon, 13 Jul 2026 14:58:46 -0700 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
>
> On 7/13/2026 1:07 PM, Matheus Tavares Bernardino wrote:
> >
> > +
> > +void hexagon_touch_memory(CPUHexagonState *env, uint32_t start_addr,
> > +                          uint32_t length, uintptr_t retaddr)
> > +{
> > +    unsigned int warm;
> > +    uint32_t first = page_start(start_addr);
> > +    uint32_t last = page_start(start_addr + length - 1);
> > +    for (uint32_t page = first; page <= last; page += TARGET_PAGE_SIZE) {
> > +        hexagon_read_memory(env, page, 1, &warm, retaddr);
> > +    }
> > +}
> > +
> 
> Name could be misleading, I would be expectng to see a read/write
> sequence in each page instead of just reading.
> Maybe hexagon_peek_memory_range?

Good call, will do.

