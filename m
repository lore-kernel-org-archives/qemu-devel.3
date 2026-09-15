Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB06CC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6H1D-00063Y-Jd; Mon, 14 Sep 2026 20:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H16-000611-Cp
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6H14-0000xo-Oo
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:27:20 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EMxxDp1272473
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OMywcFRU3yr
 zZeLxzxkjf2RWSwYw6mtwRzOHnzIMOX8=; b=AfxV3skA4nL0kZnN+8pYGpC0hvh
 4Rhv/+8XOVz2rkY2jXhmXiuzLRZhe25QAshaBdyIgmbybrV+xbOvd3B/1upF3mKd
 muigcUsn0SUK8m8dt8t1pxwzFkruErLGBisXXXTEiWdYsadjbX7X1Ju4TUqAj9L+
 2nn0i7FZ72d9ynKPO4j7EkdaJPJBGwJQ9RHG3OmrOvBgwd+g8c7+YBu+1GAieWit
 kKJtt5APAVZ4p3lawTQ3vPa4xmdOwr6bNOcLUfYPh1lIArEqy6wOFPrlf/0KuhRa
 JcdMZNrtW+ulhtRl4arZSCrbfj+Sa89httuGkK2dpzNum4f6pu3ja/4yBWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpd1f3mwa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:27:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39d865b11b4so2361004a91.3
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789432036; x=1790036836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OMywcFRU3yrzZeLxzxkjf2RWSwYw6mtwRzOHnzIMOX8=;
 b=ddQXdDuJfuGsmUxzOHg6pW2oGsiiYg0P66baL4Slf/FXzpPPaIOn//4Zr8RWLNQH/u
 5QlgwVE+bTV8TNW/fdrAQxHslTl8O6imcHZmFrV0w/FHrM4OTeu+IvHfaj/krnxQvua1
 9f1sjB1TBDWteEYsAeR+2DhKRgS6eQ9fX83FNp4cFsfKgp9cHvZHTGkSlRtuMjQvHbMC
 9/HrIws3Yn/OMifOeFf9fuHvDDBdUMGittsQq48VFbeoD61aqQti+t+42xG3sgVtHfWu
 K1LATnVvtIlopt9Yc43HiZ5uyBm8OT/erGl0PxK6s3epAIuBwrJ0LKTyqV1qq3pnZ7NC
 3jBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789432036; x=1790036836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OMywcFRU3yrzZeLxzxkjf2RWSwYw6mtwRzOHnzIMOX8=;
 b=SBZYpMfUZmmF8ej6QjPNzlkGiyu9MxILi5kguKrWv2XkO8UrHybh3NjPSPl1NdITW7
 j0SkcW+qUgezRAhQrMUw1AK7q5vz/AGxzl1C6AvhVNwtKOdIf9p9EWPRUaYOzA7nmz46
 uRnbtC1EXWcDz5faoxTuwqr/8O5keO7OE5amszGLX1Nveruv1rQRetVduGWpvZUQ/E4c
 hTa+mKwY3TuywWo2sjZ13xeUx+6NluL0u7iGKWNWjy8135sW+jJypu7Q7I103fQzPKPS
 kcoJX4Jp79iWOIXjTZkV1uPi2ol6+4Iad6RcGVRYAyiTwSJjqCTCgUWEnM4hs4VORwwe
 k7yw==
X-Gm-Message-State: AFuF++n0MJiStxLpLCKlzfFrxcTv5TNHfo38xnGNiLrKZP1vdgL3Ho6V
 j43tjfjJNNE2Rx1lxoKHIs9e56w5pwvoi8v5Qf/LPg0M9xh9QWlqHLz1H3mSKtb1rgddIlUGE5v
 TdGFnPnQCLieQgZ/fMOeA48+rjXoDHFNUUJLWnbU2mibOG7nQo3adYyirtzRcboS0sg==
X-Gm-Gg: AYBFou0NTOf2qR16SGPNnJtVc69SerBPUyt+G+n0y9gFab+SCQGqYfQQ6iMIs69BgYl
 AAFzimg5H792qlZNsqYjVlHCRKISozZrMp7Mno0dcKK1faw3H5OBqmwn0hUWEt3IfoGlqlBA5LN
 mk2d7ZnwAEgWNSXcQbcELEhF1EHvMJ7JfbuVV9VZu6r2T3RlVwtvDaMV2AmP7z8NR2XxU1Nlwwk
 McbpBDjQUc2+FzkNzJy6IpNAUWKvXbO13EV9ovvDz0mWy3LjAiuSenu5j8GI+c7RHUmGm8UMCnf
 IWorATGO1j+RGsJjdLNLpJ9DUGtKEXkp0Ky0CiEKOZwT/KtD233pQQVMicSPg9QPW/Y2XEBaecU
 Oa+7jCiWh+yjAsQI53i0zveO8/mMLpi2CxN1ZZsPe/Zc2QMNgoWe18Pd7+DM=
X-Received: by 2002:a17:90b:4a45:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39dec10b1f1mr9683890a91.24.1789432036356; 
 Mon, 14 Sep 2026 17:27:16 -0700 (PDT)
X-Received: by 2002:a17:90b:4a45:b0:398:d292:e6d5 with SMTP id
 98e67ed59e1d1-39dec10b1f1mr9683821a91.24.1789432035872; 
 Mon, 14 Sep 2026 17:27:15 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365a59b18sm26880037c88.2.2026.09.14.17.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:27:14 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/6] roms: move vof from pc-bios
Date: Tue, 15 Sep 2026 00:27:01 +0000
Message-ID: <20260915002706.36318-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260915002706.36318-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: R1Xtx38aMyO1eemxvuGjABO-kaYF7oy_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfXwh2e6wp2k3vL
 LUTNxPtUSDqeyttoXX5/ADGRveHOYeEHDFIbzCnsJarKYJL7Llj7wN0dlBJ0wMyd9y5qfqwFMjz
 +tWayycVbrMj9bLyRjhDwgVWJF96lgk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwNCBTYWx0ZWRfX0TlHzkVp+B0S
 W5pAq/gv4/FhMMd2pLBHj6NWmB1r59YK4nwPUCP8K97Xke8XFDl+v9PPBL5l9HrZApTDHl3EbEW
 SvOLhksFd3qxuuDz/N7hchlYd2HabDtnHkZcXgreaNReeCg5jQ3wvHdChuTzJ6ydaFlyNo8jymx
 o3yo/z9DpidlTzfuHYLu4d7gB/emvLCMujLa9Yl+cHvfHIph/lJ4pAw+m6j4WVUEuTmwkivGA6q
 gT/Ez500/RXWcs1gLgItkMCX6og/TkcD/OcXXVs/AnWfi8k5JyJhLktXMEF8LLZJ+kPFucyGeEn
 mJcqddHXtzLpch1bBY/4qIXholt/BGMLI0QfI+v+t9lAGMWxcLcjt5qNwBqvZ1p4T8qas3iS8Lw
 pSu9w185GmH5ZqN0kthe3Bdcmx0/NWvWdt0opxLCjYHbufq/FyNwRh8JSzLmaExDZVl1aHexjUR
 XQfJY+rHmf/004q4flA==
X-Authority-Analysis: v=2.4 cv=XKel2ghE c=1 sm=1 tr=0 ts=6aa890e5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=nVQIe4AGr7V8aNSj46EA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: R1Xtx38aMyO1eemxvuGjABO-kaYF7oy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150004
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 {pc-bios => roms}/vof/Makefile  | 0
 {pc-bios => roms}/vof/bootmem.c | 0
 {pc-bios => roms}/vof/ci.c      | 0
 {pc-bios => roms}/vof/entry.S   | 0
 {pc-bios => roms}/vof/libc.c    | 0
 {pc-bios => roms}/vof/main.c    | 0
 {pc-bios => roms}/vof/vof.h     | 0
 {pc-bios => roms}/vof/vof.lds   | 0
 8 files changed, 0 insertions(+), 0 deletions(-)
 rename {pc-bios => roms}/vof/Makefile (100%)
 rename {pc-bios => roms}/vof/bootmem.c (100%)
 rename {pc-bios => roms}/vof/ci.c (100%)
 rename {pc-bios => roms}/vof/entry.S (100%)
 rename {pc-bios => roms}/vof/libc.c (100%)
 rename {pc-bios => roms}/vof/main.c (100%)
 rename {pc-bios => roms}/vof/vof.h (100%)
 rename {pc-bios => roms}/vof/vof.lds (100%)

diff --git a/pc-bios/vof/Makefile b/roms/vof/Makefile
similarity index 100%
rename from pc-bios/vof/Makefile
rename to roms/vof/Makefile
diff --git a/pc-bios/vof/bootmem.c b/roms/vof/bootmem.c
similarity index 100%
rename from pc-bios/vof/bootmem.c
rename to roms/vof/bootmem.c
diff --git a/pc-bios/vof/ci.c b/roms/vof/ci.c
similarity index 100%
rename from pc-bios/vof/ci.c
rename to roms/vof/ci.c
diff --git a/pc-bios/vof/entry.S b/roms/vof/entry.S
similarity index 100%
rename from pc-bios/vof/entry.S
rename to roms/vof/entry.S
diff --git a/pc-bios/vof/libc.c b/roms/vof/libc.c
similarity index 100%
rename from pc-bios/vof/libc.c
rename to roms/vof/libc.c
diff --git a/pc-bios/vof/main.c b/roms/vof/main.c
similarity index 100%
rename from pc-bios/vof/main.c
rename to roms/vof/main.c
diff --git a/pc-bios/vof/vof.h b/roms/vof/vof.h
similarity index 100%
rename from pc-bios/vof/vof.h
rename to roms/vof/vof.h
diff --git a/pc-bios/vof/vof.lds b/roms/vof/vof.lds
similarity index 100%
rename from pc-bios/vof/vof.lds
rename to roms/vof/vof.lds
-- 
2.43.0


