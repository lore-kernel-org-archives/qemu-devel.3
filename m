Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F5C3C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOSx-0005wx-VQ; Fri, 24 May 2024 02:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSk-0005vR-F6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:41 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sAOSd-0004MM-Hn
 for qemu-devel@nongnu.org; Fri, 24 May 2024 02:31:33 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7e21742025aso387318139f.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 23:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716532166; x=1717136966;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLSi8jNb6aLJgWzZ+IgVUOGD8rbT/z95MGmZBAD1j5Y=;
 b=o5uMRViOiLGOEzAOlLdmmTyLqjEhAgSEmUwWh4iyBJQZp75vH8Q4uxRz/1Io1iee99
 ezwLjcrTCLdrQMrN85DKnQc7vLURo35G8FmoZrEZ/npfcqqE9tfiT5Vh/locu6i7k6/o
 U5/owv5wPnaKjXmOdaZKZt/OIwyeKcHJUjEqUbhQl0YPol0RVMk77yY9XlmD668wiexn
 61S7W4u4SXbvAzHNLojd9GbW9OieZc/QhcSPezmVS1lnDXcqesJlFsunuu33MRDo3M3O
 gC8yTweoaegzBDgJYphFOus21Qb3aCSQlxmCGDH8aDb7AjdTSsOh5tq3g7eoALHaFbb+
 n3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716532166; x=1717136966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLSi8jNb6aLJgWzZ+IgVUOGD8rbT/z95MGmZBAD1j5Y=;
 b=sqzttzyD9NSDXM/090MXvscOyu/HJb1SI206eLKCGYm06BAHzWYhSacnqDnr44sAVC
 TX1ew2Isp69p6GNeQnSO6u84d5HrzhFqTHeINbfFF2AGXSDuCqKIBO+lZXGkmDp1pP7K
 z6NvQ3T3zQWb5CbbHpoJTTVqqn3YLYHcJprxuSD5dqb0TQQ9sYChBh8/r9kYRo+pBosX
 oCJwRRW+AAw+I0E9LgPUjrVl8V/SBsiKPW5JANKXTMrh/iGmaVD5bbtveo13UGo87HqA
 c68uwSnXwjaL5DWiyQYFaCTQmdaUEpcseARe6gxq/2hyeCMNTjEJzL2PzLbO8M4URyVd
 Q9zA==
X-Gm-Message-State: AOJu0YzavwNV1nRy633aNp2uK+nx/pKV8UK2cpDfbtyyfNVyItC4+PrJ
 qYCB5zXAqpPAWwvWPEJhCseypZNZxKk4ARfW0Ck0Wbi+ObfSVDAoVH05mSsPAVKd4LxvUPar4w9
 7ew4c2w==
X-Google-Smtp-Source: AGHT+IHGjSf7eLL9s3gdKJrzMUlYptjopazfFjwToMpPPgNMFdXZ/pqdYU1i24sSXqw+P1ZuPdaNUw==
X-Received: by 2002:a05:6e02:2190:b0:371:3085:4345 with SMTP id
 e9e14a558f8ab-3737b2bc880mr17088015ab.14.1716532165276; 
 Thu, 23 May 2024 23:29:25 -0700 (PDT)
Received: from anolis-dev.zelin.local ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682274bbbe8sm497918a12.93.2024.05.23.23.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 23:29:24 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 yong.huang@smartx.com
Subject: [PATCH 2/2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
Date: Fri, 24 May 2024 14:29:16 +0800
Message-Id: <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716531409.git.yong.huang@smartx.com>
References: <cover.1716531409.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d31;
 envelope-from=yong.huang@smartx.com; helo=mail-io1-xd31.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

For VMs configured with the USB CDROM device:

-drive file=/path/to/local/file,id=drive-usb-disk0,media=cdrom,readonly=on...
-device usb-storage,drive=drive-usb-disk0,id=usb-disk0...

QEMU process may crash after live migration, to reproduce the issue,
configure VM (Guest OS ubuntu 20.04 or 21.10) with the following XML:

<disk type='file' device='cdrom'>
  <driver name='qemu' type='raw'/>
  <source file='/path/to/share_fs/cdrom.iso'/>
  <target dev='sda' bus='usb'/>
  <readonly/>
  <address type='usb' bus='0' port='2'/>
</disk>
<controller type='usb' index='0' model='piix3-uhci'/>

Do the live migration repeatedly, crash may happen after live migratoin,
trace log at the source before live migration is as follows:

324808@1711972823.521945:usb_uhci_frame_start nr 319
324808@1711972823.521978:usb_uhci_qh_load qh 0x35cb5400
324808@1711972823.521989:usb_uhci_qh_load qh 0x35cb5480
324808@1711972823.521997:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000, ctrl 0x0, token 0xffe07f69
324808@1711972823.522010:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe000
324808@1711972823.522022:usb_uhci_qh_load qh 0x35cb5680
324808@1711972823.522030:usb_uhci_td_load qh 0x35cb5680, td 0x75ac5180, ctrl 0x19800000, token 0x3c903e1
324808@1711972823.522045:usb_uhci_packet_add token 0x103e1, td 0x75ac5180
324808@1711972823.522056:usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state undef -> setup
324808@1711972823.522079:usb_msd_cmd_submit lun 0, tag 0x472, flags 0x00000080, len 10, data-len 8
324808@1711972823.522107:scsi_req_parsed target 0 lun 0 tag 1138 command 74 dir 1 length 8
324808@1711972823.522124:scsi_req_parsed_lba target 0 lun 0 tag 1138 command 74 lba 4096
324808@1711972823.522139:scsi_req_alloc target 0 lun 0 tag 1138
324808@1711972823.522169:scsi_req_continue target 0 lun 0 tag 1138
324808@1711972823.522181:scsi_req_data target 0 lun 0 tag 1138 len 8
324808@1711972823.522194:usb_packet_state_change bus 0, port 2, ep 2, packet 0x559f9ba14b00, state setup -> complete
324808@1711972823.522209:usb_uhci_packet_complete_success token 0x103e1, td 0x75ac5180
324808@1711972823.522219:usb_uhci_packet_del token 0x103e1, td 0x75ac5180
324808@1711972823.522232:usb_uhci_td_complete qh 0x35cb5680, td 0x75ac5180

trace log at the destination after live migration is as follows:

3286206@1711972823.951646:usb_uhci_frame_start nr 320
3286206@1711972823.951663:usb_uhci_qh_load qh 0x35cb5100
3286206@1711972823.951671:usb_uhci_qh_load qh 0x35cb5480
3286206@1711972823.951680:usb_uhci_td_load qh 0x35cb5480, td 0x35cbe000, ctrl 0x1000000, token 0xffe07f69
3286206@1711972823.951693:usb_uhci_td_nextqh qh 0x35cb5480, td 0x35cbe000
3286206@1711972823.951702:usb_uhci_qh_load qh 0x35cb5700
3286206@1711972823.951709:usb_uhci_td_load qh 0x35cb5700, td 0x75ac5240, ctrl 0x39800000, token 0xe08369
3286206@1711972823.951727:usb_uhci_queue_add token 0x8369
3286206@1711972823.951735:usb_uhci_packet_add token 0x8369, td 0x75ac5240
3286206@1711972823.951746:usb_packet_state_change bus 0, port 2, ep 1, packet 0x56066b2fb5a0, state undef -> setup
3286206@1711972823.951766:usb_msd_data_in 8/8 (scsi 8)
2024-04-01 12:00:24.665+0000: shutting down, reason=crashed

The backtrace reveals the following:

Program terminated with signal SIGSEGV, Segmentation fault.
0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
312        movq    -8(%rsi,%rdx), %rcx
[Current thread is 1 (Thread 0x7f0a9025fc00 (LWP 3286206))]
(gdb) bt
0  __memmove_sse2_unaligned_erms () at ../sysdeps/x86_64/multiarch/memmove-vec-unaligned-erms.S:312
1  memcpy (__len=8, __src=<optimized out>, __dest=<optimized out>) at /usr/include/bits/string_fortified.h:34
2  iov_from_buf_full (iov=<optimized out>, iov_cnt=<optimized out>, offset=<optimized out>, buf=0x0, bytes=bytes@entry=8) at ../util/iov.c:33
3  iov_from_buf (bytes=8, buf=<optimized out>, offset=<optimized out>, iov_cnt=<optimized out>, iov=<optimized out>)
   at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/iov.h:49
4  usb_packet_copy (p=p@entry=0x56066b2fb5a0, ptr=<optimized out>, bytes=bytes@entry=8) at ../hw/usb/core.c:636
5  usb_msd_copy_data (s=s@entry=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:186
6  usb_msd_handle_data (dev=0x56066c62c770, p=0x56066b2fb5a0) at ../hw/usb/dev-storage.c:496
7  usb_handle_packet (dev=0x56066c62c770, p=p@entry=0x56066b2fb5a0) at ../hw/usb/core.c:455
8  uhci_handle_td (s=s@entry=0x56066bd5f210, q=0x56066bb7fbd0, q@entry=0x0, qh_addr=qh_addr@entry=902518530, td=td@entry=0x7fffe6e788f0, td_addr=<optimized out>,
   int_mask=int_mask@entry=0x7fffe6e788e4) at ../hw/usb/hcd-uhci.c:885
9  uhci_process_frame (s=s@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1061
10 uhci_frame_timer (opaque=opaque@entry=0x56066bd5f210) at ../hw/usb/hcd-uhci.c:1159
11 timerlist_run_timers (timer_list=0x56066af26bd0) at ../util/qemu-timer.c:642
12 qemu_clock_run_timers (type=QEMU_CLOCK_VIRTUAL) at ../util/qemu-timer.c:656
13 qemu_clock_run_all_timers () at ../util/qemu-timer.c:738
14 main_loop_wait (nonblocking=nonblocking@entry=0) at ../util/main-loop.c:542
15 qemu_main_loop () at ../softmmu/runstate.c:739
16 main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at ../softmmu/main.c:52
(gdb) frame 5
(gdb) p ((SCSIDiskReq *)s->req)->iov
$1 = {iov_base = 0x0, iov_len = 0}
(gdb) p/x s->req->tag
$2 = 0x472

When designing the USB mass storage device model, QEMU places SCSI disk
device as the backend of USB mass storage device. In addition, USB mass
device driver in Guest OS conforms to the "Universal Serial Bus Mass
Storage Class Bulk-Only Transport" specification in order to simulate
the transform behavior between a USB controller and a USB mass device.
The following shows the protocol hierarchy:

                      +----------------+
 CDROM driver         |  scsi command  |        CDROM
                      +----------------+

                   +-----------------------+
 USB mass          | USB Mass Storage Class|    USB mass
 storage driver    | Bulk-Only Transport   |    storage device
                   +-----------------------+

                      +----------------+
 USB Controller       |  USB Protocol  |        USB device
                      +----------------+

In the USB protocol layer, between the USB controller and USB device, at
least two USB packets will be transformed when guest OS send a
read operation to USB mass storage device:

1. The CBW packet, which will be delivered to the USB device's Bulk-Out
endpoint. In order to simulate a read operation, the USB mass storage
device parses the CBW and converts it to a SCSI command, which would be
executed by CDROM(represented as SCSI disk in QEMU internally), and store
the result data of the SCSI command in a buffer.

2. The DATA-IN packet, which will be delivered from the USB device's
Bulk-In endpoint(fetched directly from the preceding buffer) to the USB
controller.

We consider UHCI to be the controller. The two packets mentioned above may
have been processed by UHCI in two separate frame entries of the Frame List
, and also described by two different TDs. Unlike the physical environment,
a virtualized environment requires the QEMU to make sure that the result
data of CBW is not lost and is delivered to the UHCI controller.

Currently, these types of SCSI requests are not migrated, so QEMU cannot
ensure the result data of the IO operation is not lost if there are
inflight emulated SCSI requests during the live migration.

Assume for the moment that the USB mass storage device is processing the
CBW and storing the result data of the read operation to a buffre, live
migration happens and moves the VM to the destination while not migrating
the result data of the read operation.

After migration, when UHCI at the destination issues a DATA-IN request to
the USB mass storage device, a crash happens because USB mass storage device
fetches the result data and get nothing.

The scenario this patch addresses is this one.

Theoretically, any device that uses the SCSI disk as a back-end would be
affected by this issue. In this case, it is the USB CDROM.

To fix it, inflight emulated SCSI request be migrated during live migration,
similar to the DMA SCSI request.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0985676f73..d6e9d9e8d4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -160,6 +160,16 @@ static void scsi_disk_save_request(QEMUFile *f, SCSIRequest *req)
     }
 }
 
+static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    if (s->migrate_emulate_scsi_request) {
+        scsi_disk_save_request(f, req);
+    }
+}
+
 static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
+static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
+
+    if (s->migrate_emulate_scsi_request) {
+        scsi_disk_load_request(f, req);
+    }
+}
+
 /*
  * scsi_handle_rw_error has two return values.  False means that the error
  * must be ignored, true means that the error has been processed and the
@@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops = {
     .read_data    = scsi_disk_emulate_read_data,
     .write_data   = scsi_disk_emulate_write_data,
     .get_buf      = scsi_get_buf,
+    .load_request = scsi_disk_emulate_load_request,
+    .save_request = scsi_disk_emulate_save_request,
 };
 
 static const SCSIReqOps scsi_disk_dma_reqops = {
@@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] = {
 static int scsi_disk_pre_save(void *opaque)
 {
     SCSIDiskState *dev = opaque;
-    dev->migrate_emulate_scsi_request = false;
+    dev->migrate_emulate_scsi_request = true;
 
     return 0;
 }
-- 
2.39.3


