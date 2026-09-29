Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4069CCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWde-0004JL-Sl; Tue, 29 Sep 2026 08:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWda-0004JC-SK
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:08:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWdZ-0002E4-9j
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:08:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TAjKJ93870510
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=+kDypYw8uNdVo1iNR3iY0p
 KnF8Cbi+Mp/niQ9DNtKUY=; b=XxGRHw7HZGH2vu4E71PkqH6O7td8DQKie0YpeO
 sGL4eYf2Md3TBcLK986QKW3n7kq0T80b+01jaYyyxsf5eCPmt3BlP6h3v/r3SI1F
 CgZs4suZIGzqT/jeQYBl8sPFt8M0Z3SYOZG10zXsALoWZ4Ha5ap83RKX9YpxqrD7
 i9nrh3uPmIGyaiMzTpaLONfi+JVVSCfrGommANkV5yyR55SkfZ6lF6oLsnyr60tr
 97fyD723yHmOJ7iWHrNiq2tgMWxJdPA8jtp30Uit5NM97eyxm44ON3dlQTj8ujOr
 0IxaNFsJndiJitOMxmw6ebmofxgudYGSIUJosPqLVISZ0x7A==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnbwct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:08:42 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5d1d0c60c5fso277227e0c.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790683722; x=1791288522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+kDypYw8uNdVo1iNR3iY0pKnF8Cbi+Mp/niQ9DNtKUY=;
 b=Szy6quXqlpqPY5lHV86mLTSMDSvldX+OV/xu1mbKHrD/ir3Z0lSyntP+UF5nfW8Tts
 RtpNWUp85R7D9ohqFUkuCopO8ZzfDDJ5KGKl6mDYR+BVvhVNC2e9Q+JoFophRL4HZh/V
 nI9mlhwGxdzb/FpnWCfnk+j8MgYGtxDAaB+3DS7tz/RDYw6AG8+Jl5BHES9AgjI01IMi
 QvlQJ5fyLGhlHmXJzww316kQiul9yjEwL0PstH5o2ZaaLCzIqaBCPOCbVZHp1a7kszjT
 A8ZPQyMaRMkJ3/HTd7ggLBajUw0v2wbZsHZ4wW/7VcmujgHK7yeWgjTQL7uDP4dnai5s
 OmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790683722; x=1791288522;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+kDypYw8uNdVo1iNR3iY0pKnF8Cbi+Mp/niQ9DNtKUY=;
 b=00eh7voEIEi3aTwPA5n5cRZzNzsC8XW7rJJMT29+Be2jzATsX1qVVo1giVLQndX9fu
 FQXnNtUr7jvTSl/ZZrYGI3w6azoakkfyuiJp53KFjGpHkNWXODhfj06nYV1Cjk3MlSf3
 8ESxGcdj5avhS0EhcD/zqLx9Og9n2j87PZiKRYL12R4ztLLOpgn/KrScoqG5yqubqT95
 RmOvuOPQPLZSpqWSvrRPJWLIMRtTXRW8l4APHFLiV94m6CXqE1xtvmyaq/MJK9ojlHks
 6iZ2XCqeE2Dc/6wp5f2BSxcahAb2a0Dr3QgtS8c1Whj8XhVJlrQv+C3SUCTJWxnUcA97
 gvmQ==
X-Gm-Message-State: AFq9FYL5QrTtk2dE1omU6caCkVnMkoQTtxmU6BMfaaYWF0lIGqvOxVAa
 +TZJbrsrZKR7Pr+/1ob3H4IExcJGL3kTj9I0hHxoFIQGAwQXh+ArIlzI0cZTdJSXc+V4tT0gEj5
 vVMkBkMppA1l0c3r/EgV+5kULyJQ8lFI87RwvVqWOxYXZE2T4ekzbjbGfeYpmoZG0IQ==
X-Gm-Gg: AYBFou2JP1bdr+Xu2zmr3wYxtDv1SGS2rG45t31oREk2RKVQQriC+KJJ8MmAwwZnWC3
 dj8Tm3ybIyXuT6i3TUfGt7bv0SrxU3g8TkHfYUk++wqOn4iRD/76TjyKyIVTsBGC0oDijVFkACL
 MQEKUmvgv2b2o8I4TdGooDiTly7/dK/Qo2gwqClOmUn3/JWreMxfWrZ7hn1C6Ju8wb3zRDB7ZPR
 NM9Vu1JHoj4/LDeCRQjot1utogE9PXF5qCorGmOyLB2a43g6Tg2/S7KXp95sHkoiBHE1jLLF6xW
 Ds9lz0E62fe9UohKiz1pzcRB1wm+G+xtNT9miFLSiBez/p4EbiNAH72qkxVaebcQjwN0EDRxUb7
 05FsJ1+XBy+i/iJaR5cT9GPbvQ47+6zYSubpZEI7W
X-Received: by 2002:a05:6102:5112:b0:7a1:f7d2:e84b with SMTP id
 ada2fe7eead31-7af1eff69cbmr4938500137.27.1790683721734; 
 Tue, 29 Sep 2026 05:08:41 -0700 (PDT)
X-Received: by 2002:a05:6102:5112:b0:7a1:f7d2:e84b with SMTP id
 ada2fe7eead31-7af1eff69cbmr4938496137.27.1790683721279; 
 Tue, 29 Sep 2026 05:08:41 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00d0ea7c0sm77761795e9.11.2026.09.29.05.08.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Sep 2026 05:08:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 0/2] target/rx: Define exception vector constants
Date: Tue, 29 Sep 2026 14:08:36 +0200
Message-ID: <20260929120838.13583-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gox5mIQcqaZDlpyVzl0D6F2Z_7oDeee1
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abbaa4a cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=DAsVBvhwAGrwFLCKlOcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX6Gn7EN3ogHgU
 HnCYN/54LyO43lZakDNzpZC/LjQY90cxcuXdDbedXLi2ORWqq3rr57GbMBZfeYCkp8bRlHVGmeN
 0SlN2lSzm0XgO+8zuV42TXf9y0FYQRho5SWzrVc3NZoBSn54DHOJuYTRFU5tVNrmC3fnc6mI0az
 EvqOxyANj9qysW5aaa/Sp2bMtfTp9kjz63WRpPgMI++uBj3YSu+wR6y97bKOPhyHz1AQqLk+499
 HThFrcJlj1PhwmCRPup5QuyopmXTAyU8GVMLqOFJRb2YtUDmr834K5f8c6ceFju9rynIqCiv5Cq
 9ZLiXeM3O7wT0SAE4zyjfKSmRu0wNeh2q2m3heflDOKGtl4Sl53NoA1pDanWcYEteLnbmOAhCVf
 xgj1EbW5cXNuSPcAL6EZJ8Llm2E+OF9060MNwrLW8sw5dHpsAPUkKQYi/1PYB8Wxwp4RqL7ZzWG
 lYBmf3F5aXjKoI/vWjw==
X-Proofpoint-GUID: Gox5mIQcqaZDlpyVzl0D6F2Z_7oDeee1
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX302YAyGBx03V
 PmZQGwMQQ3kYwHRqupj3tWDbLZK5wkGrM5EEEfdgn/J64aYvz+iJmI0xwPEZNi0ruaMhHV2dSh9
 U2mo6pgxfZHtcFseL+GSSzHmKXbcOq0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Since v1: Repost as a series (not buried in thread)

Unify BRK/INT0, replace magic values by exception vector constants.

Philippe Mathieu-Daudé (1):
  target/rx: Unify BRK and INT trap handling

Yonggang Luo (1):
  target/rx: Define exception vector constants

 target/rx/cpu.h       | 13 +++++++++++++
 target/rx/helper.h    |  3 +--
 target/rx/helper.c    | 21 +++++++++++----------
 target/rx/op_helper.c | 17 ++++++-----------
 target/rx/translate.c | 23 +++++++++++------------
 5 files changed, 42 insertions(+), 35 deletions(-)

-- 
2.53.0


