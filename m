Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF1D606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FR2PpYz9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N2KwaCKK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7xJ-0006OL-HV; Wed, 28 Oct 2026 14:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xD-0006MW-Q4
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:00:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xC-0000ZD-2p
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:00:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SHIJSt884196
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Z7/z9q2Vha+IHnm5r/BwEs
 5LaD2zJOBcmTh/3l/aCDo=; b=FR2PpYz9czL3FvVUrZnsjZrpqTpXRXwAW8qpwi
 5iLSXNtAMKYdQLvakNqZ3vsNo8iw8n/xqc0Jzoeh9I2kxkhej0rdkVj1m9AYUjKK
 Mhssen1NGuIGYBjqiqXIgGwUS9sOyiLSxDtB0pLpUx4en5ZtzgZsfylRJpG5KYTw
 VugoZEyXnBjwgTwok+McUDqiJpkDTIUo8/3lskZhWM3p2Elk2jhAhk+XQfSb+VFL
 LK2E7Sqc1GxrjHheex6jqrnkkBfATkRjp2oN0MQOjnBmWJ3opkUtRhGNunnEJRk9
 hZfojxlZVfcUNn5XxaOA/HRhr9I4kcv0eCoCtPjN7l5pBdUA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hknb285eb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:00:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-944101e6367so89104785a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210444; x=1793815244; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z7/z9q2Vha+IHnm5r/BwEs5LaD2zJOBcmTh/3l/aCDo=;
 b=N2KwaCKKDPc96MEc+9gddef7WlE5L/nbOOexcZRmK6JaVRPmkcf6aJyuWynbr1w+DW
 EGLaqjeh2aaeKs3X857LzC4xfDILKa3Tn9kCKjI6pjTijPbbvINBO0UvuJIXwRx7/+S0
 FBxmbMKpFSAIUT6K8aRUvznDW/JEsl2+hwaTiTVMiwKVKdZXkJ20T1WwvXLyv4LVT4bG
 hF4eF0d5LjG0oDpT8BGjDEhreqTM+WrEkTkkfLJfq/9/krww9w5LK4dHfgwEbtLzuJp/
 9TAokgOng4SBot5pkvckmSBh+cbPOPjFBOvTzE6weGyW27TQPloJFGco60HC3daGZxKV
 lu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210444; x=1793815244;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Z7/z9q2Vha+IHnm5r/BwEs5LaD2zJOBcmTh/3l/aCDo=;
 b=M2YEl83tULsf8nQszNykMYIpdwskULFl3vnTNfxqUn73PiVXSIDO0/pDnSKQyaYDFy
 JrXC2oTMKOVMHzVdrB3u5dnGcU7jqgLMKHnOvVzYoRZDxtf1UoN1Gw49exfh1w8OmPsk
 YC13tw+9fDZll+/YV3TRakAVU+1dXWZVwU9h+NE5mLi++Yx/w/aLZ6JxEyD6s3IJEN0H
 V5TVE7Eg3AjBL+OI1Z1YES/0PIx0tYF3DMJ7O+6KZne+NUY6WEuCvBUBGyxbdVXwS3wD
 HUVS5Wyc+xri5ox8ybgJd4cNihoTkWWC9mpJGMy5NmDW0JrbTa3X5efxhQlxKRBuXba4
 yJew==
X-Gm-Message-State: AFq9FYLRM2OPrSpIkb5hJXJydEDxtCIi0TtmCRFH/1CpYQc8/kxl8V9k
 /DdWrDj72mkcA9qdj4yUaOas+sprWRxyXZRQSxRiyBu9saOMzvXiArQ8D2aILZrveyXjHj4HJz7
 +iVg0sLFh0zvZX5gqoCq0Px1bf5wCLpSE9TA/ktKjVHnP9WV89yDLwS61BUOhnea3A1JI
X-Gm-Gg: AYBFou3+LZLWa6hqRwY7ng4uyMCRla54Gk7K0QdUCOLy5+dygyzpoJlVK2JISDnSIso
 S6uVwni/cPpkjXgkmuS/BcQ4DJQgV6f0QTK5coISNUHH05nJMIL7a+YIpIVTOq4+hZkVB7oVATl
 p61P936suEJFDwl1+YosbFwwHfEKRYSMW+9zu5jv/L5tZz0YRtgqTkupidjgBi1t6JLlx1UBBXw
 IMCIOUQ3CEsvtAeYSzmWjMyXRuZOreS4ucV5oomf+nHtgjoInlJkNS0psW/kmcA5Sh2WQ2I6LI+
 iL5UMHUjju/fEI8su0WyCvAuUkT4D6jGTZjGvtsPvJsvZR2cqmfb3lz/kPAvuOj3l2F/CtNWlkj
 oLa07nfYO8G74WWR2sh3BzAi5XfMTTb3opFBYrUsZ1WsLcbvkyjN28HX48wi2cWDqQoKUO5J9tN
 kwFib4ukMzKbT6lZa3s1v8Wg9RiG273Q==
X-Received: by 2002:a05:620a:2944:b0:93f:8f9:7a83 with SMTP id
 af79cd13be357-944133fd229mr49301785a.43.1793210443879; 
 Wed, 28 Oct 2026 11:00:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2944:b0:93f:8f9:7a83 with SMTP id
 af79cd13be357-944133fd229mr49296485a.43.1793210443370; 
 Wed, 28 Oct 2026 11:00:43 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc39a8sm30714423f8f.11.2026.10.28.11.00.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:00:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 0/5] target/mips: Constify and remove TARGET_BIG_ENDIAN uses
Date: Wed, 28 Oct 2026 19:00:34 +0100
Message-ID: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Yu2a1IYX c=1 sm=1 tr=0 ts=6ae2384c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=xeeYTCwNatxreDsxmdIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: QA7ABV0cZGvHRf-mi9lPJuQWiRAGUwmc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfXzTEtUsvFvq7o
 9OJKx4hDatwGMI+5EonIp7g18d8T75XDGVSDWB6Cm07IYN+MI8hT+0fayhWja9NUlLIuZvw2hxe
 izv+dR1HGQOw8kCoPysob3ZEm3URFlA=
X-Proofpoint-GUID: QA7ABV0cZGvHRf-mi9lPJuQWiRAGUwmc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX8cVNea0kRhdL
 s/8UTU1Oeod2qnqAZwxM4yzZ0qGz8touRNg7iipjxuCduWgScr6IMKe30ZtT99RljsTUs6HgoPY
 eC8c/33cTdq3r2gp1AFS/4uHWjkpeSZnmxYf/4J72iiPB5F2Tkt/XUYp+8cOMEgnmQMypEwQWw1
 V0+C2EdmlZZh4kbuXDzh/Y2LS5CCiJZ60/ENgFKMecWhRNQce78WZ/YEK3SG9ScZE4NUfcoYIW+
 lPQMhBiMugpdg28L3v/vyB6SGYBIrIQKjAyKyVH6qkFQpNPasc3VYce1hECVW08EXJaBC3NqOZ1
 GmHxvcjt81jQCJFEKLPP3Ke5CtZtAjDi2pgCnC3DaL8gaUDWeaLwEvtnhKDNA+Kn1SXlvJ0lGG2
 NoGh+KpNuedaMj3M8CW+9bZ3hqlOZW7mn6FsHrXY/z89CfMjkeNaui23IJmDEdMQ54yXLgxhEcX
 ryS0kLh+RDaDM6LSS6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Patches 1-3 progressively constify CPUState,
then 4 and 5 remove dependencies on TARGET_BIG_ENDIAN.

Philippe Mathieu-Daudé (5):
  target/mips: Constify CPUMIPSTLBContext::map_address() handlers
  target/mips: Constify get_physical_address()
  target/mips: Constify read-only CPUMIPSState arguments
  target/mips: Do not use TARGET_BIG_ENDIAN in cpu.c
  target/mips: Use CPU endianness in MSA LD.D / ST.D helpers

 target/mips/cpu.h                   |  4 ++--
 target/mips/internal.h              | 10 +++++-----
 target/mips/tcg/tcg-internal.h      |  2 +-
 target/mips/cpu.c                   | 13 ++++++++-----
 target/mips/system/cp0.c            |  2 +-
 target/mips/system/physaddr.c       |  9 +++++----
 target/mips/tcg/dsp_helper.c        |  2 +-
 target/mips/tcg/exception.c         |  2 +-
 target/mips/tcg/msa_helper.c        | 18 ++++++++++++++----
 target/mips/tcg/system/cp0_helper.c |  2 +-
 target/mips/tcg/system/tlb_helper.c |  9 +++++----
 11 files changed, 44 insertions(+), 29 deletions(-)

-- 
2.55.0


