Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E703F606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dO6ij7Eq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=akuwBDBg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOx0n-0006X2-Ig; Thu, 05 Nov 2026 07:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyj-0003r3-17
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xOwyd-0005qB-Sw
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 07:54:03 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A59tDhu3684470
 for <qemu-devel@nongnu.org>; Thu, 5 Nov 2026 12:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OF1920oRRrnVJwyvR3UnD9uFml4Mh2HOqZa4NKLWuXc=; b=dO6ij7EqxG5Fip7w
 N0X4M5ByjWycqk442isgUBZKyMVkOM5eQLM1QJG2ohGcfhSMuD0jazea+NU2xC6L
 Q/EZvuumAFroAewkNSY+lRP9X6x0xtyvFCoW/x//07F2dsAlvX8uxQuIqMPMZ404
 6PBLy6PEvJC2gqO875k2s7A3fnoH0BzTQEuTYed5L2Zp30/7xShJVdW2c6NAgb3k
 eA8UUbMCQpqg2vH3M7Jrx/jVgaxtlE6KYnmqXQoRXNgONZJ2aQl11Lf5YZwT+2pq
 zWnt522f/v8nzQK8HjGCF3GNvLaFRSiGalaXrjAL8MJb4hV5LMLvIZGTgBdtClm9
 CW3Paw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43j4ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 12:53:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93e92aad34aso426475785a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 04:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793883228; x=1794488028; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OF1920oRRrnVJwyvR3UnD9uFml4Mh2HOqZa4NKLWuXc=;
 b=akuwBDBgQu+qv3Nt+96kxn9YgToZK6y+JR7BgChI7YW/mRLIMYBU5gX7OcglY/nP7j
 oxZm+6IQ+tDfyK+fc94vzOXB5nRhUUJ42x3uS0aTYGatZ91P1+G6Rq0e3YnVfAecVUwj
 m4XRyHEuiTepVQEwzOqKuVirjpEQWeorVfCe5Ymm6VaRnHTo+cmvZGlZQWmDKGq1jQKi
 Q/byPEC8CRmbZsAmoghHdY0QGZb35tJZm8JYsRGZRDg63+Ypygxe5AwHp9YLqOEaF/wT
 WzTlL15NmlAzI/DWmmqKQ2vczJ11n/WAnl/TmDPM4PDaKva1ymjJlm6u9Tym8dwxSJmG
 yKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793883228; x=1794488028;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OF1920oRRrnVJwyvR3UnD9uFml4Mh2HOqZa4NKLWuXc=;
 b=v5jmeYOTWJy+nWjeVMPhIGkjS9dCl0PtPiyOh+b3Sk/7OsVUXWlRFwQEmYXHYh1m3z
 B81WZTcurJ5sBurhgXX7xub1Keq+L828eGLOw2kbCyzVOQ9bL+8VtDvPQ4LbKgIRce8n
 Atdvz+FshvTHoK0RPbiAyjLC44WRXY8ZvBVxPlT1Fe29RyFJ/YnbKBkaiONW93FBU8RF
 g3rGPyirRXQHBoz8/YytXAuNUjzDXNVmU34xivjZ8nEnmtjfNOLR9CNgWuvKg0I/6yZf
 IsY1gdqPhSbIYX7UXvVhZ9R6kB0PzmJq6bmnidwLbRYAh1WAZt1Tbkoq4ULhMgZxYjZp
 +mgA==
X-Gm-Message-State: APuU4Z+ElwBnZybeNen7dhxxZBKsOstzRzr1Qt7C4E6idC/AmEaoWqkS
 OqHT0W/hdtxbTKUzwi0H1wIExCz+A8S+oxWRFpaJ5mHVy8cTnC9xXsZ8/87rD4uSdpPXB6vlgGW
 bn1ETaG4bszjpXqUdt6syIBVuwvPP7vkIMDR3CgpAuFN9W6H/5dD/OdavxWevd0EhHg==
X-Gm-Gg: AYBFou3FxM7tSJmqeqy0F2jr53uBrjiUFNdb63fl9kCqo8Zo5eEx2giIVl63e0S5U6d
 OL2ciyyEeQAUEjr+rWJ/ZyDxrY79llSFn4sBYrI4JbucKy+DGnot2OXCDResf8i0nPcBu2C8G1p
 47tLxZtIWMFLIe3/7C2efBaZ9SpBPbQhfS5Ju9uLv2kC9JSYOkaaf+QFPSC6CXIqaDTUZp42ZNe
 BZB8/MbrzuWMZKn2PLghLId0M4VVOs7mB+tfQaTmA4pdWlY687r/8jHsG4gw4H7gbFUy8kLTxB8
 9tfiIu9br4Q8Ojo9thZYiHXZ1maowwm+7ZbTNr6779dZrsAr8tVg5+f3FQcHrRVyftl33x5+6zz
 9FIAxhMOWmw3MK+kLvu9KTOfaxud/6YPrrXgf74x09T4FQS9KSg0GOYFrvVMozLATqaENtuM4HP
 75bShUSF3SyNvYEAk78nypTjE5JMeWlg==
X-Received: by 2002:a05:620a:471e:b0:93e:3824:4123 with SMTP id
 af79cd13be357-944216fef10mr3362080885a.65.1793883227479; 
 Thu, 05 Nov 2026 04:53:47 -0800 (PST)
X-Received: by 2002:a05:620a:471e:b0:93e:3824:4123 with SMTP id
 af79cd13be357-944216fef10mr3362078785a.65.1793883226954; 
 Thu, 05 Nov 2026 04:53:46 -0800 (PST)
Received: from localhost.localdomain (104.171.88.92.rev.sfr.net.
 [92.88.171.104]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4d0ddcfa78sm172214766b.0.2026.11.05.04.53.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Nov 2026 04:53:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowangio@gmail.com>
Subject: [PATCH v2 10/17] hw/net/eepro100: Replace deprecated sprintf() with
 snprintf()
Date: Thu,  5 Nov 2026 13:51:55 +0100
Message-ID: <20261105125203.40320-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261105125203.40320-1-philmd@oss.qualcomm.com>
References: <20261105125203.40320-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RPY0zyaetIJx0geA12HYZX626doD8owa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX2HExxeTWqq/4
 mcIJngnX/e50gpXj9VLWhXAh1SewAg3DxD8HHKqcwHpgOilFabrHnf4HrqMBT4O5sfhSCBEiLix
 TBGSBORvX1WeYrmJhQg3xfVPKN0IbR0GcXoMqVouisIjM19J+o1HoK7KphRQatXJEHnXzfvEaBd
 8tugE/ZEOL1WvNZwhhf30IA7QQwHga/7MvlBjjKA5cDHZZCdjhz0yZifH3iEQuCpuJg4ygIhzG/
 7GcaU5GZX2CN57RNf205mBAZ6VfGc4yynkjWg2qYrYO0pGDJLuXi242GyQnoflMvYVSviIOGW73
 OnZvLcJvSQ9tNAlCtRTKMDpy9/WEsuTY3OWstjzke7NnRU4Rta0HiYRV34841oGqQJ60AQnzDIZ
 z5qieIjkIhUoBi7tqASCPefqZ9SNAURY7vLwxiRef3cubouE+nSgRZQvwHaCaN0PdFabqCubmvD
 RxNrtp4DcWQ0MRS69Xw==
X-Proofpoint-GUID: RPY0zyaetIJx0geA12HYZX626doD8owa
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec7c5c cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=pBdeej1U2jlWEHTh2vTwjw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=3I_bySaw9zVCgE-qlKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MSBTYWx0ZWRfX4MVuXyZ7K+Ab
 dnV6ROn7JyE3ZlisYa/jyzV0yTsWopv1OOlzdKvOH7qnCPnGDiHthWEukp2jvjoqhdhQ163HKDR
 ZrzbulNkR1FwUA1nRFrF6XYrExmltGk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050051
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace sprintf() by safer snprintf() to format debug dump
silencing -Wdeprecated-declarations produced by Apple clang
17.0.0.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/eepro100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index aaa3eb60f8ab..44eff5fd3ad8 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -369,7 +369,7 @@ static const char *nic_dump(const uint8_t * buf, unsigned size)
         size = 16;
     }
     while (size-- > 0) {
-        p += sprintf(p, " %02x", *buf++);
+        p += snprintf(p, sizeof(dump) - (p - dump), " %02x", *buf++);
     }
     return dump;
 }
-- 
2.55.0


