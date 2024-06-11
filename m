Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD8EC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2RM-0006t4-2N; Tue, 11 Jun 2024 10:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RJ-0006sB-F5
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH2RH-0005xe-7D
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718115930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCobMURdlNUETrYRQMkj2zrFOissVitaIBLYUuDT5qo=;
 b=NB6uKAGeTljrFi0NwOZGnE5n/bs+Hcdzomp/IDEpMcbVdxxslhemnQIpXIUZK1nOV0MM1t
 F6AEdIspH72v42apTWvwFp6nMxtydGMMTyaJKUfG0k8+dD+QImgLeBo76AWXuokrC7n/R0
 8q4JRBlV5dd1eEeHJHiK7TOx+Os3WDo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-AaCwaaLRNtu4y1qTPwGjCw-1; Tue, 11 Jun 2024 10:25:28 -0400
X-MC-Unique: AaCwaaLRNtu4y1qTPwGjCw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-57851ae6090so3740028a12.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718115927; x=1718720727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CCobMURdlNUETrYRQMkj2zrFOissVitaIBLYUuDT5qo=;
 b=avU60DTEufcv5QxY7TO9+BaqOtj3HoYfk9KqH9/Qty+lXg06JQmlvYhNMWi3NyoCzx
 iU5fTVR0s/P2Qof88AzGGG9jK9o0YhN9nvTQ8nZtqVPQWwImEVnvxiuCdLXdq3QyoOvL
 KTW3xiAwqRngagQxNx8tt7TGDH91OYG+nZa1erccXT9J2eIgMUtNaEanmR2DXzqLkBY2
 4x5h0HpJhN05iqPDLgliSlBh8iox7Ff4msOcax2UWi7LPQLIzZBLzte3XszXSSQ1KE1K
 lUmvzs+q2g3WLdy7ofBEC3OycUYdja7wruxnHpUagQ72UeXTpnl1nN7Yob3gKR/7LdUA
 6Vlg==
X-Gm-Message-State: AOJu0YzlguagiyPq1GhsWm3IHOMJ3EpALPoQdrdiDaFVIkPVKBDyqtRb
 OR5UtEywSjCwtfv7u39U3nwc/zReghuYb5UEKaPtgkM+4lMqc3Ck5+7+VMpbev2HUdzfdhmp5UZ
 TEEzCUB/K6MZaxL3f6mtO45ydLe17FsOgEAxagPsZQwsUzSFl0bK0Yq2QsgPEObJDHapSnqEoFd
 G7zmdHcZQDEAr5MUPJ4p3XUSNE+UtWI7tzKjwi
X-Received: by 2002:a50:d796:0:b0:57c:6ed2:870c with SMTP id
 4fb4d7f45d1cf-57c6ed28bb1mr5137320a12.2.1718115926832; 
 Tue, 11 Jun 2024 07:25:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDw5y0OBurQJbFKGcmWz+70RAEJ+i4KBiRpsvxDXpQUNh3/R4Y6HU12+WrjdDPyFuEaXdhiA==
X-Received: by 2002:a50:d796:0:b0:57c:6ed2:870c with SMTP id
 4fb4d7f45d1cf-57c6ed28bb1mr5137310a12.2.1718115926274; 
 Tue, 11 Jun 2024 07:25:26 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c6d34f607sm6196801a12.30.2024.06.11.07.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 07:25:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 01/25] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
Date: Tue, 11 Jun 2024 16:24:59 +0200
Message-ID: <20240611142524.83762-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611142524.83762-1-pbonzini@redhat.com>
References: <20240611142524.83762-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Hyman Huang <yong.huang@smartx.com>

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
Message-ID: <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
[Do not bump migration version, introduce compat property instead. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c   |  1 +
 hw/scsi/scsi-disk.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c93d2492443..655d75c21fc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -36,6 +36,7 @@
 
 GlobalProperty hw_compat_9_0[] = {
     {"arm-cpu", "backcompat-cntfrq", "true" },
+    {"scsi-disk-base", "migrate-emulated-scsi-request", "false" },
     {"vfio-pci", "skip-vsc-check", "false" },
 };
 const size_t hw_compat_9_0_len = G_N_ELEMENTS(hw_compat_9_0);
diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 0812d39c023..a67092db6a6 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -114,6 +114,7 @@ struct SCSIDiskState {
      * 0xffff        - reserved
      */
     uint16_t rotation_rate;
+    bool migrate_emulated_scsi_request;
 };
 
 static void scsi_free_request(SCSIRequest *req)
@@ -162,6 +163,15 @@ static void scsi_disk_save_request(QEMUFile *f, SCSIRequest *req)
     }
 }
 
+static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    if (s->migrate_emulated_scsi_request) {
+        scsi_disk_save_request(f, req);
+    }
+}
+
 static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
 {
     SCSIDiskReq *r = DO_UPCAST(SCSIDiskReq, req, req);
@@ -185,6 +195,15 @@ static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
     qemu_iovec_init_external(&r->qiov, &r->iov, 1);
 }
 
+static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *req)
+{
+    SCSIDiskState *s = DO_UPCAST(SCSIDiskState, qdev, req->dev);
+
+    if (s->migrate_emulated_scsi_request) {
+        scsi_disk_load_request(f, req);
+    }
+}
+
 /*
  * scsi_handle_rw_error has two return values.  False means that the error
  * must be ignored, true means that the error has been processed and the
@@ -2606,6 +2625,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops = {
     .read_data    = scsi_disk_emulate_read_data,
     .write_data   = scsi_disk_emulate_write_data,
     .get_buf      = scsi_get_buf,
+    .load_request = scsi_disk_emulate_load_request,
+    .save_request = scsi_disk_emulate_save_request,
 };
 
 static const SCSIReqOps scsi_disk_dma_reqops = {
@@ -3114,7 +3135,8 @@ static const TypeInfo scsi_disk_base_info = {
     DEFINE_PROP_STRING("serial", SCSIDiskState, serial),                \
     DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                \
     DEFINE_PROP_STRING("product", SCSIDiskState, product),              \
-    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id)
+    DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id),          \
+    DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, migrate_emulated_scsi_request, true)
 
 
 static Property scsi_hd_properties[] = {
-- 
2.45.1


