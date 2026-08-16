Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8280FC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvc8Q-0000sW-Sc; Sun, 16 Aug 2026 10:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8P-0000p7-3F
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvc8N-0000ep-FA
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:46:48 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDlh9J3227987
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7Ha+GMiwFB7MMVYOPKKxOSDbK4itG+KVW/54HtjPNhc=; b=Y5rNNaq9UMywerhy
 cSE+MgmkFX+BcYwwm717a+qm1JcLcBHO3MV6XFBcOKuld6NrRHLpM4TGaK+LXntg
 +tH2cQ6eIPHfvloH1Zxb9dos3gmSPL8XuFT2lPvRglgiWyAg38qm26N15WusPFid
 3dT3I9kKsmxF3tQyiSYlUWi7Qa5rs4QYn2FowBukJ0tGqXUC9BZNk8RfSW6F7vLh
 DLbqbqJ+miOEasvrGL8uMhEiaND2o+8Fwl12VHYPGmyp/ryaSgFT6PBpHa64KSBc
 8MZ4zejgIulr/coXWKmlmoBuC1YfOalHccUV8oCxNuT25T5YR+bHlv6C89Evq5vD
 IC+ZYA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g322q996b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:46:45 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso25855406d6.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891605; x=1787496405; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Ha+GMiwFB7MMVYOPKKxOSDbK4itG+KVW/54HtjPNhc=;
 b=EjMm3WEHq6Wi9wiZr4j0AyoRxtCiT2eVuJugNzsdsiwAdVo0jvy8FBnrbRiPqB6v/P
 GSblWZ6bZu2sxyktIot/kjmxISRBvqhbtJUaYhHcSW4EB+OAAh9h8zG1CVbfImVpLGUr
 vW264hjgEHtueIQ1tTiPRkN2n0FtiVuex+NpvTZvENvIp6CiHblYXIrI3Qnf+5rZMNwV
 wHTrh70ydqbBNIwtYdTv5uL1Kor1FGwr++LnPTiTT/LbiEvrBkSZXlqtOTmrmPLUGfNu
 olPRuJTvrJjlEBC+n64i82UCctD3mtfcANM/3/DHG9Z59FWlo76HxBnS4OjC5T/2drgh
 keWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891605; x=1787496405;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Ha+GMiwFB7MMVYOPKKxOSDbK4itG+KVW/54HtjPNhc=;
 b=KrBHwT8GlMn8t+2VM4hfyFNhpNdi2KjkeDSX+Ki+IU+40lWSgrIQ6KoxcqvxxlPw9O
 2P3jtQi0JODr7XtDi/x1aDPZUhsno9H6yyqjjYozqQ71P1HMTkokKacWFOktHURZZKEs
 GXJvDNk8TcavFHsLZab7W/qEjru3qMbpLpkrYNlZMr7+2pzqllbZzMAHhVI35x7PlJcF
 yUBp1ulnWD00BHFTpvpL2teKcUvXfwSdBAU3kRA1J6HAwWTnaLeedRcz3neOXgLSnQQ2
 0Il2wApKxWck8UIGlh0HKoxwLSxa8UuCnon4KUNs6pKxXYUAgd+zfQhlFwRyJlxf7wiC
 DUdA==
X-Gm-Message-State: AOJu0YyRMhsxBcRr78X5mx/ZTqlm5681yb5rGytPCacgVGhR1j3Z3jc4
 QJ9HY4KblxT+H1Al9O8p6ozPlqJAn77JDq7VGEvyNJpSI8K18NtHVCHRH/6v88y1w/N64q49huD
 OK6881K6v9418Yl/sWYZqyNagZpodZxY/O7F/wVcm1R3tT7UskS1ROUlt1wKG0fHWxA==
X-Gm-Gg: AR+sD13QjJjqCOAdWYaNOdlzyELmUg/HEJcZRh//5NyITtu9Cs7TVocECY+g1QQpzhZ
 zvLlUY7PTgBmarhqKcwuVvm6dGU7K9ZWrik5vMqHUEv5zXv5fss8lp71MOyvCsg8uQCLIYCfwe1
 8nVgwnFkXazsrGfjrT6Aor/LEdd9ayv6U61dCqNEtuc2jPjbaDMRThNZn4NIKFjzhWSqMNXCbVF
 azNOaUR/dwL+osXJDr3hRJ9QSoZYAswttHEUSi+EzRxHkP7eQ1Mdb4t0h+b/ABHe2eQ6vFfSTgM
 7aL4+zXYyk5wRtws5VYS9AXLB2cbHGlmNra/PKa745yeOZ2gMPsDMyO5VVqFIAvPTjafDvBpbwD
 QS+rPTsvX5VyEvFSOBoOMEfwog35w+9itBi89veLj/A==
X-Received: by 2002:a05:622a:4809:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52d8530f238mr210927931cf.8.1786891604815; 
 Sun, 16 Aug 2026 07:46:44 -0700 (PDT)
X-Received: by 2002:a05:622a:4809:b0:51b:f857:cf82 with SMTP id
 d75a77b69052e-52d8530f238mr210927551cf.8.1786891604282; 
 Sun, 16 Aug 2026 07:46:44 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1d90sm25781096f8f.22.2026.08.16.07.46.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:46:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/56] hw/mem/memory-device: Use qdev_is_realized()
Date: Sun, 16 Aug 2026 16:45:05 +0200
Message-ID: <20260816144556.69009-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX8YmvM00OTQRj
 I77JHyuvnKAcpwYH5L3WzHrWmkssCVBx3RrZhQyBsmtHUmF9irHmMNRzkhmiziiwO01G25dybx3
 xvWfl7m1O0Dcf5CoKMf5rhfy51hZhDE=
X-Proofpoint-GUID: MGy-sBY3DYTJf8d6GvXuxAOL__D1w-6I
X-Authority-Analysis: v=2.4 cv=C5PZDwP+ c=1 sm=1 tr=0 ts=6a81cd55 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=yA7JfjU0G8p-xxjCkkIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX5u8EHJiRpIAS
 Xi5id0N9o3F+tkoLbkb6K6Slw3ugR9UWoFRAz8YfIZX/7hjufObKnfNXMib1owvxPE4heTaMLr+
 Zj0AM+ikRJ5fahlzRIoxDKxYHhqQlnWvJ2K75B+zVnKtTmOglfIb8RKqkEHwK/pdlOw53jQbtrR
 CPJaBsouilKzh7954wkB+LjZLQ9fGpjx3EZRuXr6GkVoR7z1e/jKbTr/eSmLkXY371BUuMS3QaW
 9X9yiN7Q8yc21RVJKjVVPq3ARu/hboEZAIIRDZk0tq8oK38+nDO7oELvAvmtgcz914pFbWhF6Tg
 FO2iDFCXbP759vmpvuGGE0PapTyQ4lrMXV82gtmG3xzHxsz5PPg0nBCwTznmsEVLA0n50PoyIal
 xH8Y9ho/2N9YbhIMxWIHpZ2XeK1/xNFdRyaZX7x461VWKb/uEg7DkjlY2+Nm0R4NUGMLCS/zJat
 8IUKZ7Y2SZ/RtzLPOgQ==
X-Proofpoint-ORIG-GUID: MGy-sBY3DYTJf8d6GvXuxAOL__D1w-6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160118
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

DeviceState fields should be accessed through qdev helpers rather than
directly. Use qdev_is_realized() instead of reading
DeviceState::realized directly.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260721-qdev-v3-5-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/mem/memory-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 9cf82b84cf4..24bebfb6b31 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -59,7 +59,7 @@ static int memory_device_build_list(Object *obj, void *opaque)
 
     if (object_dynamic_cast(obj, TYPE_MEMORY_DEVICE)) {
         DeviceState *dev = DEVICE(obj);
-        if (dev->realized) { /* only realized memory devices matter */
+        if (qdev_is_realized(dev)) {
             *list = g_slist_insert_sorted(*list, dev, memory_device_addr_sort);
         }
     }
@@ -326,7 +326,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceState *md = MEMORY_DEVICE(obj);
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
-        if (dev->realized && !memory_device_is_empty(md)) {
+        if (qdev_is_realized(dev) && !memory_device_is_empty(md)) {
             *size += mdc->get_plugged_size(md, &error_abort);
         }
     }
-- 
2.53.0


