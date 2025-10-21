Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8551ECCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 11:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBAxO-0008Gj-91; Tue, 21 Oct 2025 07:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1vBAxM-0008Dv-9k
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:55:12 -0400
Received: from m32-23.eu.mailgun.net ([141.193.32.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing>)
 id 1vBAxJ-0001wz-Aw
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 07:55:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=slonk.ing; q=dns/txt;
 s=mta; t=1761047703; x=1761054903; 
 h=Content-Transfer-Encoding: Content-Type: Cc: To: To: Subject: Subject: From:
 From: MIME-Version: Date: Message-ID: Sender: Sender; 
 bh=6dveA7Bc3abeeRSBTidZ0/ShQem6EzpLqb7v5SFYum0=;
 b=rA2VZvUz2O+K9l3uP5PBi3W3Gw4jB+qCc2Kmhg/hjxczupXOuMau63ZlWIgDn3WANEdaFYGQrBWp9nfAX7FC3bgnMHXGw6mepL6wHKloVep1El5k9N9/qDgBO6gZXAzDISTGO/KFcaMXGnOihjia7aV1pH259JU1EDAG9FdtyvDo/XIkPowQxEkBr47y03TGa1aeJ5KpmaR9txc9AM4AoC255oyrA0H0lkzZxmZ7lLmUR0G/aUzFVvEPYhwNiT9ItXTFv7C6sXyWqEVr9unMqulq17tnNLHgEymwei7pKJS6XzLERlkx/fjWWIW6bvv3FMzQrJGeg6Av2cdSm2VR2w==
X-Mailgun-Sid: WyI0MzM2NSIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsImEzOGY0Il0=
Received: from mail.slonk.ing (127.183.70.95.static.turk.net [95.70.183.127])
 by
 6953e733b90d5ef343660439d7c29c450468d4a3aa3b1c95405cc0ef60d8ffd0 with SMTP id
 68f77497f52e2e44eb13b126; Tue, 21 Oct 2025 11:55:03 GMT
X-Mailgun-Sending-Ip: 141.193.32.23
DKIM-Signature: v=1; a=rsa-sha256; s=202407r; d=slonk.ing; c=relaxed/relaxed; 
 h=To:Subject:From:Date:Message-ID; t=1761047701;
 bh=6dveA7Bc3abeeRSBTidZ0/S
 hQem6EzpLqb7v5SFYum0=; b=aVvwt44tmoagFknVMnzcB1/iOHZG/HVYNMS2KiXFk4Pi0et6t3
 ylVnolG5AIBqzt7zLsQmjgjJFnEhPuMpaum5nOVm8Nf/QAlyJpXt8p0t0jFks5hFp0OquuB2wG8
 7ifbj7NVGwCBzh2xOMVb/QZg3efbpIR30HrflWB4hF2wRLJ6SKpMnh/BBcGzm/Gi8fMrp7C85xD
 Fbdrurmu14WXy0Ihn5hIJt1aqKH+LPpmBEcBmo+OYWMJnEzw8cbHcOud0PNaWPqmBWSjCWnxcB+
 1t5ee7Uu5l/c/KjUweFCoJVDzpdGS24QmZfgZzTrJHKlP//a1r3AH9gqwXCazQwC+qA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202407e; d=slonk.ing;
 c=relaxed/relaxed; 
 h=To:Subject:From:Date:Message-ID; t=1761047701; bh=6dveA7Bc3abeeRSBTidZ0/S
 hQem6EzpLqb7v5SFYum0=; b=i8W4e1oBaB87vMlgeA9BX97CvfETwGFrugsBQn4ivEiVXu38gY
 gDU2L8MfVo9tphZkGtz3D8FEEKXfUrAZDPBg==;
Message-ID: <9051e5a9-92ad-4279-b8fd-f4cd92e05bac@slonk.ing>
Date: Tue, 21 Oct 2025 14:55:01 +0300
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: virtio-gpu refresh rate option
To: qemu-devel@nongnu.org
Content-Language: en-US
Cc: qemu-trivial@nongnu.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=141.193.32.23;
 envelope-from=bounce+23e6cb.a38f4-qemu-devel=nongnu.org@slonk.ing;
 helo=m32-23.eu.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  slonkazoid <slonkazoid@slonk.ing>
From:  slonkazoid via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

currently, the virtio-gpu module does not set a refresh rate, making it 
default to 75Hz in the qemu edid generation logic. i wrote a sloppy 
patch that adds a `refresh_rate` option to virtio-gpu, which propagates 
to all the devices based on it (i was interested in virtio-vga-gl). it's 
not of much use by itself but when combined with something like Sunshine 
or looking-glass, it can provide *far* smoother guest graphics than the 
inbuilt display devices. i have done a bare minimum amount of manual 
testing (virtio-vga-gl with venus XOR amdgpu drm native context 
streaming video games) and it functions as intended, and should not 
break the code path to fetch the refresh rate from the active display 
device (?), however, i have never contributed to QEMU before and i don't 
know the customs concerning testing, documentation, etc. if there's more 
i should do, please tell me! if this is something that would benefit 
QEMU, feel free to merge it. it's not a copyrightable change anyways.

 From bf599519fcf0fb03bffc2ce82051c91472591f26 Mon Sep 17 00:00:00 2001
From: slonkazoid <slonkazoid@slonk.ing> <mailto:slonkazoid@slonk.ing 
<mailto:slonkazoid@slonk.ing>>
Date: Tue, 21 Oct 2025 12:35:57 +0300
Subject: [PATCH] add a refresh_rate option to virtio-gpu

Signed-off-by: slonkazoid <slonkazoid@slonk.ing> 
<mailto:slonkazoid@slonk.ing <mailto:slonkazoid@slonk.ing>>
hw/display/virtio-gpu-base.c | 1 +
include/hw/virtio/virtio-gpu.h | 4 +++-
2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7269477a1c..8e3ae958bf 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -232,6 +232,7 @@ virtio_gpu_base_device_realize(DeviceState *qdev,

g->req_state[0].width = g->conf.xres;
g->req_state[0].height = g->conf.yres;
+ g->req_state[0].refresh_rate = g->conf.refresh_rate;

g->hw_ops = &virtio_gpu_ops;
for (i = 0; i < g->conf.max_outputs; i++) {
diff --git a/include/hw/virtio/virtio-gpu.h b/include/hw/virtio/virtio-gpu.h
index 9f16f89a36..8831514bb3 100644
--- a/include/hw/virtio/virtio-gpu.h
+++ b/include/hw/virtio/virtio-gpu.h
@@ -128,6 +128,7 @@ struct virtio_gpu_base_conf {
uint32_t flags;
uint32_t xres;
uint32_t yres;
+ uint32_t refresh_rate;
uint64_t hostmem;
VirtIOGPUOutputList *outputs;
};
@@ -173,7 +174,8 @@ struct VirtIOGPUBaseClass {
DEFINE_PROP_BIT("edid", _state, _conf.flags, \
VIRTIO_GPU_FLAG_EDID_ENABLED, true), \
DEFINE_PROP_UINT32("xres", _state, _conf.xres, 1280), \
- DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800)
+ DEFINE_PROP_UINT32("yres", _state, _conf.yres, 800), \
+ DEFINE_PROP_UINT32("refresh_rate", _state, _conf.refresh_rate, 60000)

typedef struct VGPUDMABuf {
QemuDmaBuf *buf;
--
2.51.0

