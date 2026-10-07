Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F624CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:24:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEaz3-0007U6-8r; Wed, 07 Oct 2026 19:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEaz0-0007Om-QT
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEayy-0001Jg-ID
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:23:34 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LuQdG2098818
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=iUj2H79bZ6zfQPI74wgeNG
 Wz4BdtVflx5SbXqdQdqtY=; b=KUhh/aEU8TYEHiE6K4LwkxAqbrSB7oe/ft+pmz
 IepZOshVOU3gD9UHRyHkFOUIZO1Xo8lXZ6TGwhMgBnZlk5qojDIT2h2WT1aaMs9/
 HR3DU9rJVcCuM19mMBxD1Q2IHq8WA0BKyYZzxAt27a+U5yrLgfrIlGvsGAQex2L6
 iUU9T8bcqqr7G5uC5E8Rwdqmgv+A3zkVOwIE0YEpEa0TZPDHiNnB+iWMPosHeOuh
 0rIWYDE0sYS5uCxkH7N8TnAoMPfiVX/pR1suxsUpjqaGydBYn74GVgSQ79JGlh3C
 EPj4houVcfHBTBZ4yB5UO8J2MHtUJHHkrGGb3KpNHJMLS1aQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xefg7xe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:23:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so761788985a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415409; x=1792020209; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iUj2H79bZ6zfQPI74wgeNGWz4BdtVflx5SbXqdQdqtY=;
 b=V+C7KKSOxg1AY/oWsiMyH10p0s5MtXdgbYz8GCdIw08gXRMYyD2v721kciWirEdwbf
 rC9FLH828D5DYjCzN84Xw3KfmzkwAQSLQomEfD0zKLKECeceITs3VaXw1f7KqFzILKYE
 IpPBAdmQcNBWlQHST+WGS8n1gfbQJyYa39LI1rWJ4EaHoaWwdfhEPKqxL9RDM3A9vXSv
 SYfdUOWYwhWvcG2iYS0raJ2/5+avG0v7Z9qDeuUIKcOw1ZT671Al1STsYHPOGXM47GQy
 EiTz7f/G4JNu6PBK8RmACm6UId57hAej3zd8eQWJmA3KYVI/xF7UEPTV5oYmGZHCFfuq
 f/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415409; x=1792020209;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iUj2H79bZ6zfQPI74wgeNGWz4BdtVflx5SbXqdQdqtY=;
 b=aHqJn56jCWxLBubbOirxjf315/PkUE1rIZ0kp4bFTs523Z8TbZjahuWLgQDfxh6ZYF
 dGRXnNqeUFQavEAFpGbJCMMo8ziXa3I49/mZVEhLzZ0CQUe5e4cDpEankhRxTHq0kdAi
 5Kx+hh7Gu4ZnRej5yrou0JbUrvA6nkbDH8bE1xN/I5fd9sloZ6G0ZRZ9h2r5UlZ56dkC
 geJflxPkxtJ828VEuZPj+B7P4fYGFRTkZTZiWMIwor33v+sRFnRt5FNPL0vpqjAsFQst
 9ML2QNOAZ5VYyPNOBN3xhSOvXJ5g2IGQPdkLudNcXP0eUdLb490rrTZtXuNPJqio1447
 WcMA==
X-Gm-Message-State: AFuF++lR4SKn8+Qi8rUN07pmik5EvNZiqjf3ryZ1/7ssWrK9RUgYD12z
 Bd4jgDY5Ah+5ZRefSufiWkJfBjMhAgP4JMcPkD36LknE00ZMIDKiRn3b4DO2U8iP9Tm3z4d3plL
 QZZl33iHSCoqFStu0aWo6OXN6UHmrcu/KAxuTHw6JKIeTR84zbygdaL+3ViDarxr3Aw2z
X-Gm-Gg: AYBFou2EY1kZy1z8PLyUy79BoJYOeRITJsxhg/hOxYoi2sKKZ5G2r9zTuNwArk47twT
 mQWUK9arqaYEBfpDTSLP7Hz/cSuFs9w90HYT4EeHfn7mFhKkPtykLeA5J3dIfoA1OQzwjDeH7Ca
 KHJGyILVMcYj8GUOFS+5ApP2E2BHnu5SPzYNZtjcl1WBKHAMUGrzGb8su2LPd2wLlhgaDqHmEQ8
 zoaM1laSNa8CBJfSYLJFescy7dgvhge7jvNipowQAjj5mCmuF1FxhoeRU5YpqFWV20AWAMYCben
 pexiC932NShZHdTal0yUuz1HEsC44GGL1cAlkW07NjoSlEJlKs71p+Ub7xUTXy/ke9ym6Yyrsx5
 zB5P7jTnoArErAd1OCcwHLWwR9n0MnTbBiJDiQqK5
X-Received: by 2002:a05:620a:801b:b0:93e:94f2:adaa with SMTP id
 af79cd13be357-93e9b781880mr816043185a.32.1791415409113; 
 Wed, 07 Oct 2026 16:23:29 -0700 (PDT)
X-Received: by 2002:a05:620a:801b:b0:93e:94f2:adaa with SMTP id
 af79cd13be357-93e9b781880mr816037585a.32.1791415408593; 
 Wed, 07 Oct 2026 16:23:28 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1843bbe82sm21869735e9.13.2026.10.07.16.23.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 16:23:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org,
 Yonggang Luo <luoyonggang@gmail.com>
Subject: [PATCH 00/10] gdbstub: Remove target_long_bits() from GDB register
 reads
Date: Thu,  8 Oct 2026 01:23:15 +0200
Message-ID: <20261007232326.66240-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX+aOit0yBoWze
 QDteN7jIHmd4L1DAQ3urXFtM46ZCk+6yRbdjB76s2H4NLAx1ivQx5WdyuLFZvvKxkfHy6rx5zv2
 Lh4GdS5Svd2KmCyw79U9ZrxoloLjwyWmAJjRhq3uvsdmOc9ffa69gLA12oMQjpIq+WTuZxK5nLq
 4WMGeuR+Re/qQdhuRY1s6Tv+mvAE/zrfB1wIkKkfDw7C4YhiftBv3iUy6pjxGaJjGPjo/VwNgmP
 PRztjzHKM0Wylhk7lWdgsoYt8G7TrT6b7O5k8EXhnNvgnkjq/+YCm/BVVvxAHMGuxpesQ8j1EgQ
 /wjHhN1wDFEleGpzOurtZ+POuK34fpGAZkUP83F2u5+Zmp7lnhXObNn29jL+xQy25meR4H/yKNw
 hNEAqNUAqoMXAZaQ1YFGJoD2tF0K8qWlDNhQXdnmdG5r8DFFVlAK4p0Hv3KP+SfPAN8hugA695x
 WJtZ4veCIBtKbWVh2AA==
X-Proofpoint-ORIG-GUID: sNbaYtBVCcfgkyxCo28Ei0wW5sJAf5N4
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfX6JGjhjZAWzsu
 Q6YHq0rw6YnXW8LqEJhTwTwiCDWsJnlZwdLAr+wJaSZHWQEaPx2YPTA6HZJ7oQRzX6vZLibGO6Q
 ERsBuShgEilmAIlCepx1rkt8nqOGZ3s=
X-Proofpoint-GUID: sNbaYtBVCcfgkyxCo28Ei0wW5sJAf5N4
X-Authority-Analysis: v=2.4 cv=YbwodARf c=1 sm=1 tr=0 ts=6ac6d472 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=8hlkq1QN6mvqOSdO4wQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070093
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Prefer getting target register word size at runtime (via
CPU state) instead of build time.

This allow to remove gdb_get_regl() and various target_long_bits()
calls, and to eliminate the TARGET_LONG_SIZE definition.

Philippe Mathieu-Daudé (10):
  target/sparc/gdbstub: Replace gdb_get_regl() by gdb_get_reg64()
  target/mips/gdbstub: Reduce to a single gdb_get_regl() call
  target/mips/gdbstub: Replace target_long_bits() by mips_env_is_64bit()
  target/ppc: Factor ppc_env_is_64bit() out
  target/ppc/gdbstub: Replace target_long_bits() by ppc_env_is_64bit()
  target/ppc/gdbstub: Replace gdb_get_regl() by ppc_env_is_64bit()
  target/riscv: Factor riscv_gdb_get_reg_mxl() out
  target/riscv: Replace gdb_get_regl() by riscv_gdb_get_reg_mxl()
  gdbstub: Remove unused gdb_get_regl()
  include: Remove TARGET_LONG_SIZE definition

 include/exec/target_long.h  |  8 ++--
 include/gdbstub/helpers.h   | 18 --------
 include/user/tswap-target.h |  2 +-
 target/mips/internal.h      |  5 +++
 target/ppc/internal.h       | 11 +++++
 target/mips/gdbstub.c       | 85 ++++++++++++++++++++++---------------
 target/ppc/cpu_init.c       |  2 +-
 target/ppc/gdbstub.c        | 38 +++++++++++------
 target/riscv/gdbstub.c      | 35 +++++++++------
 target/sparc/gdbstub.c      | 13 +++---
 10 files changed, 125 insertions(+), 92 deletions(-)

-- 
2.55.0


