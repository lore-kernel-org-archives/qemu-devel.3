Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F8ACD98D5
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 11:42:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXdnm-0003OU-PJ; Thu, 11 Jun 2026 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdnl-0003OM-C0
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wXdnj-00036Z-Ry
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 07:42:25 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BA03H7318908
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TJbwIACDwNpX9QBAwrlNVowvoKq6uPMfJ12yVCslT9A=; b=VxVvm8GX6lzpZ7wd
 8Fz/nksvbxX1B407vdDpfErHr+RUwpFkhPjGwuxrS403ArhGVjVWgOAjX0gbsDav
 xcd9fMgbC97H986HQI3yPF7vbKQOOw334KIMuNqFtl4VWpOSSFn72ndRFMUesi5w
 6C0duqjAUeevdvdCbL5iRsUgJpMckEBY7G8t9JZUUBsVLu8XsFPxEWCsBQ5wPNnb
 VUCKhlq2aqWzSF41W8uWoCrPt+ohSaJRDahGK7ZCzljXPTFxl/HpujMslEazwE6a
 ZDMoAcNkykV+2578d7wmK24d/UmM837TjxD4HryDtcEMYjoyOE46RUZfMkUT+1I8
 2xNynA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6sk84f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 11:42:22 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175bf22b1bso109425751cf.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 04:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781178142; x=1781782942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJbwIACDwNpX9QBAwrlNVowvoKq6uPMfJ12yVCslT9A=;
 b=Hjp65XvvdQhS42NDUKfdRbF8QxcQerLDZftVbl6gxujn+cVbZafZT0faYHiLVvOToR
 Ti1CflfDwCR7wty4vY7UvDEFop0wL32eqyQHU3Wbjyti0W54VY7NluCHza5EUY6gkn81
 5zB4SjJaxy/zQ0Km+eAAYsuNNDtm68wevmxG9Fcr264YT2DEZWtqCoWtvFd75U6ddvcS
 wokS4N6x+ZuzV0Cr+8crSthZUYbaNkVXugpsa+RtSrmpqmnskZDzjRNqYA2w3+qsFWVx
 9M85t+kb2x8uSa5PyIKv0URYrNEiejaVxAe2Q46fEsmnfn7krsAjCqBsPHG4qWXx/jVm
 OFLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781178142; x=1781782942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TJbwIACDwNpX9QBAwrlNVowvoKq6uPMfJ12yVCslT9A=;
 b=GOi6wvKIWCcpoL1N218lNavtXy0fW/nEGuyPrEsU7w/beE6y6r1zDb4QLCAMqckhU6
 wO5cb+gQd1QTVskzYhgxBsrB4QZ64JZ37IZxFfaFK65wWJ40drWgHqVZdCj8az8i4l5c
 i0pvBqC9hmGHBqlsXHzeFX+CCByCXDmItTi1i2R55aFoNb5PJRsGn7E5eOy0L37ME2YG
 FmETQrFZoFl9PR4tpzUqSgvQG20taFiYlgWAswbnPWqA/IBb1C91QVMiFHXxQIC18GPy
 Ncg4hIeIjS3kFQBdWpz5j9prPi4e9SzxV4/UC3jAICn1bTtAX9++aeC/1DrObucKl8t1
 CNlA==
X-Gm-Message-State: AOJu0Yzx1DdtnClGK+A7KciSEuAPx2o+PBeRk9c9rK9uEY7RYdDXj3dp
 tATGeYm9Lk2YuUvHxk9Lrd+KGjWeS1Phvebk3O/xe36tk8HlYYLLP+SGh2YeytlbrgKDtHJBmVL
 HPC719Kt5f5tmPQnPi+ZiJy6eZCMH0DO4CmkTp2z4q3zBgLOo6/njs4oaUt1EejObyhqi
X-Gm-Gg: Acq92OHPV5GKZp75DSx8GGrmTyuDiNxXe5k8++n/FY4UZ47SBOnAicIbeMXcZXCen38
 CTf9EMvQt8LiaqNPjozdd3JAbNORdq+RCmU37CDFZeEJIDJhZIDL6dEQ03ZTdAM03O+bA+LrfKc
 Bry8mIytgkJ85HKVLGXGa1EkN8P6FgGJZKKQ7HLKWuYmeCoWz4TzxEKVK+BD8lscv5p31JqM36m
 0xZpOR1jGgE6Wa5eJoI9YNAm0dZJuulrxxFOWhN+Im9sAipdmuvW3gVzHeb2nmqm75fZE3wSuL2
 PxQJhPWAH7Iu3C00ZuycBmufvKgDSnp4r8t0DHtZgyTML7fcCA+L+eKd+IBicggIwCGrUTi9MLX
 FBSpdVkbybs93ys0wJzRxgmFh2JlcaELwM/qxdw8/v7tSw34xggC23YMXetSDDXnusEI/X+gxC+
 zhmyEdlh910gP1/Q==
X-Received: by 2002:ac8:5853:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-517edcd83f3mr41564571cf.9.1781178142125; 
 Thu, 11 Jun 2026 04:42:22 -0700 (PDT)
X-Received: by 2002:ac8:5853:0:b0:50d:7aa1:f405 with SMTP id
 d75a77b69052e-517edcd83f3mr41564231cf.9.1781178141710; 
 Thu, 11 Jun 2026 04:42:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm82990988f8f.13.2026.06.11.04.42.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 11 Jun 2026 04:42:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/2] tools/qemu-vnc: Have console_get_mouse/keyboard take
 const QemuConsole
Date: Thu, 11 Jun 2026 13:42:11 +0200
Message-ID: <20260611114212.27472-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611114212.27472-1-philmd@oss.qualcomm.com>
References: <20260611114212.27472-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ET3wQOHZFgMQkPq6eR4pjxO1jAj-7OyQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfXwH0qdYRoQ+qG
 4CXPNp26NrjbzFWBC2uRYpUHbucDY5rpzbxVqQOiCCguQv5QC7HONA2o7Zxece24iqU49Efcqcc
 vGyOeBuIK3HM3HiKIlb2L1qaNdrJW7U=
X-Proofpoint-ORIG-GUID: ET3wQOHZFgMQkPq6eR4pjxO1jAj-7OyQ
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a9f1e cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=WD0V6lTw6i1yn2txnTcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNyBTYWx0ZWRfX/ofh40AEJ1ez
 5/7IWWNeT5CJW+VdDQu5F9rUHvhXxF5xFeDKiJCrH1d84KOE2aGvlgORuikGY+dAzrYsX1JU54w
 Q0bimVpD/ajbdLmS2rHN0oNVqJpadyiWMgE0ySL8iF134J/cm5Hhg9PHwPkKuSfQteLu6magfyJ
 jUL8iF8ObxMmSsjK38x96VcR+Vn3vtlmLW2AhEga0aUocw2JSpiIebowgHyaZrWMl3VpNDyv2sa
 PAIxDbS3hV35GuESpSypAr5utetUbfDB6sREF3W+tz5dqxHdvkOyM8ecLd7+6xzXieSxrAq73fs
 kiIP/jeB86qVrGf9Rh+gJ9iFP8zeD1jHgdzmRmxuSAufAt5Ag1ZCWG7si/oIbcOZHoZxrYMXR+3
 NjIjM74kYirewkzha6SYVwTx3Gj4iv9+Cidk4QX9CiKo1lqnOVgPOWDXh7mKAI2zRo6D42St0q2
 DG9BcZ5OF9JFmeDuiBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110117
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

Both console_get_mouse() and console_get_keyboard() only
access @con in read-only mode. Make that argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tools/qemu-vnc/qemu-vnc.h | 4 ++--
 tools/qemu-vnc/display.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/qemu-vnc/qemu-vnc.h b/tools/qemu-vnc/qemu-vnc.h
index 6e483e4b475..15e4ead80b7 100644
--- a/tools/qemu-vnc/qemu-vnc.h
+++ b/tools/qemu-vnc/qemu-vnc.h
@@ -26,8 +26,8 @@ void input_setup(QemuDBusDisplay1Keyboard *kbd,
                  QemuDBusDisplay1Mouse *mouse);
 bool console_setup(GDBusConnection *bus, const char *bus_name,
                    const char *console_path);
-QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con);
-QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con);
+QemuDBusDisplay1Keyboard *console_get_keyboard(const QemuConsole *con);
+QemuDBusDisplay1Mouse *console_get_mouse(const QemuConsole *con);
 
 void audio_setup(GDBusObjectManager *manager);
 void clipboard_setup(GDBusObjectManager *manager, GDBusConnection *bus);
diff --git a/tools/qemu-vnc/display.c b/tools/qemu-vnc/display.c
index 8fe9b6fc898..b485cbe3100 100644
--- a/tools/qemu-vnc/display.c
+++ b/tools/qemu-vnc/display.c
@@ -433,7 +433,7 @@ bool console_setup(GDBusConnection *bus, const char *bus_name,
     return true;
 }
 
-QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con)
+QemuDBusDisplay1Keyboard *console_get_keyboard(const QemuConsole *con)
 {
     ConsoleData *cd;
 
@@ -444,7 +444,7 @@ QemuDBusDisplay1Keyboard *console_get_keyboard(QemuConsole *con)
     return cd ? cd->keyboard_proxy : NULL;
 }
 
-QemuDBusDisplay1Mouse *console_get_mouse(QemuConsole *con)
+QemuDBusDisplay1Mouse *console_get_mouse(const QemuConsole *con)
 {
     ConsoleData *cd;
 
-- 
2.53.0


