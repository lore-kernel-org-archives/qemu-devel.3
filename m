Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C76ACA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACL-0002cE-0i; Mon, 28 Sep 2026 08:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Refael-M@hotmail.com>)
 id 1xB4U6-00053A-M2
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:05:06 -0400
Received: from mail-westus2azolkn190100000.outbound.protection.outlook.com
 ([2a01:111:f403:d004::] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Refael-M@hotmail.com>)
 id 1xB4U4-000407-4D
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:05:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN61BRVH/m7B/7EO7iBtIDoMEsIWfUpHj7uwUwXPdY6dd6V93ygBZelv1pmw/3y8mbNR+sm4WhcWFXP9CMOYwue8Gk0pk664QVT5KrHzYsvpCor4gXSUrDe4mYAYOYpzBo49VRZGuVPlRP9DhCH3zRWj7Q1bKBPER0XnXkWcRdKiVW4toGzEJNmE70LIKncvfTPzuI54qnBwO3xhhsGl91pEWJLtrdSgs8Be22U8I4Z/SDeouUY8fYEAcn/ulzgVW/z619bW7VAMf2ZQv4EyoeGUQ9MlmElovzsEgjyCsfKCVZUOo0gfx8VFReGg6ude1u6sxs/4TrPOshvxpOVIDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY10WmyLt5qYI9PtP/LNIlv7BmEeuxAzi1+oM0/UUYU=;
 b=mwSjTiPhQt6xaYOuSncUlhg0E7o7FTYcZ7Za51jZsYb2H4pqWHWIuj46gJbr6ZSzX5jbD7rW+D1nnys4zCsReLFjn4n9Kw7lCbSZn7aprz11FwYDoxPy3tAeUM0kkuB+4YLMGzSjB4D2rudZc18r8mdE0S+v3JubJp1HkWYOI76xo7tbuX4P26866VT/vMkyTJ/2JVj0vr5thc6NOz+uKTCu5eAv28/cBCeQfCGv1GDcVWb/YFpOVTrj8oq6mhBjstwOkk7pRqNwmfMQ3UCUu+iZTAzTDt3M+ZAnOnkq60W01dFv+qF9s9PEz0uQEB76pD2/LsMsLpeXmKIPsKhyWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY10WmyLt5qYI9PtP/LNIlv7BmEeuxAzi1+oM0/UUYU=;
 b=P7b4i+ZlfQr7GUnqkKuGjn/cdGJlP6+RuGpUB0S99AllTRazPFCv0WIXJSEXwwJUkkaalJNbVf8jJdB4MB7RRw6hgUgeOzMoQVTkVZVBSKsNXcLoZ66p6kxj7mv1wDQVemEPatuePh6kzP8NBBlMEvuY9lpvrokzfVjmk/s/S27w3zIJPILEDNuowkOCUYGjaDQsbVBbYu+wtJ1pDH4WmhIMomv7cdBrD1jQyN5JFW4yXmbXnwGWKtwX3nZOIFWuFcjfOtKfQphL2W1VTwevCNZWzmH1eab9v/WwifIti+gkXEbNf5PoB6frd/ct+JDxKn/Nm6uh9YM928Ho7Kpezg==
Received: from LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:408:2fb::15)
 by CH3PR84MB3545.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:610:1bb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 05:59:57 +0000
Received: from LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9151:9e8:f98a:99e5]) by LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::9151:9e8:f98a:99e5%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 05:59:57 +0000
From: Refael Mantsur <Refael-M@hotmail.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [PATCH] hw/hyperv/vmbus: allow receiving outside the channel notify
 callback
Thread-Topic: [PATCH] hw/hyperv/vmbus: allow receiving outside the channel
 notify callback
Thread-Index: AQHdTw6E7JfU52EUdEqH+DwCWNoxNQ==
Date: Mon, 28 Sep 2026 05:59:56 +0000
Message-ID: <LV5PR84MB40263D472C5CF968889420A9968D2@LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: he-IL, en-US
Content-Language: he-IL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV5PR84MB4026:EE_|CH3PR84MB3545:EE_
x-ms-office365-filtering-correlation-id: 148dc2e7-b716-41dc-b19e-08df1d25b94d
x-microsoft-antispam: BCL:0;
 ARA:14566002|8062599012|8060799015|19110799012|31061999003|25031999004|25010399006|24071999003|4140399003|37011999003|39105399006|24021099003|41001999006|20031999006|15030799006|15080799012|5062599005|40105399003|12091999003|18061999006|2607281247196008|102099032|440099028|3412199025;
x-microsoft-antispam-message-info: =?windows-1255?Q?6ZfHC8Hjj+zYASDn3gBd7FO5KhTA//3VP8UyaJS1kbwi72wwEv8ixenx?=
 =?windows-1255?Q?BO36P1ikrl+P+O5fOkJ45zyEfukcHXlkVIHvzhM9ERwV3KHxVGfd6zTq?=
 =?windows-1255?Q?ij21pFa+q02n+Co0UMD/J18zbJSlh/epuQEGkCaZ8AAkZQTVyfN9NjWY?=
 =?windows-1255?Q?9Jq9C1mGwuGw/lLealZLdRYTYHMIY1OaMxHDLMxZzRXtMm5xxB5jj76j?=
 =?windows-1255?Q?55JH/gvgYropnraKWXEvCCtuECG4kxFXEbyKCP/K6bEeLlfgnoa5Q8Fl?=
 =?windows-1255?Q?ghvy73AM9Nlu/N3ubCttXp1Vi8ous8F5qQx7/XdrPrLQxoJe3jhiTw6J?=
 =?windows-1255?Q?T0cURxBkYNaNRpyiQq+d9Mk2hGg+3oJH18kGTY/p5NXuLQGkp+LFs+39?=
 =?windows-1255?Q?bpzYYEItf6u8vwYfDhME+d26dtuUyQgVKUVHeFU4zPuPXKT/mDWFXIol?=
 =?windows-1255?Q?ZVJcd3UamHJdnL3hWQQXeaO6gfXQwRqXaHBgMV7TqF6Xn4+45jYh5WGT?=
 =?windows-1255?Q?f4/f3f3rPR4jqw8QvbmmnmYYvmzcEI0vNd8WBILa+DByYh+esn5u03O7?=
 =?windows-1255?Q?4Z1i27QkI/r0zzwK/VWyk38IuglmN5Ycy5nVh4/aUbDHJiPDaFHnWTDC?=
 =?windows-1255?Q?e1fvR+EX8uAURsU7zqpV91Lrr7ujy7nmCvs4A0jDuE2r8jZmqFN9Dh0h?=
 =?windows-1255?Q?0RejjB6ZXZfmRJq+skkR44YsWYzQk3XA8091db2khWN/6/rHGg5vJc57?=
 =?windows-1255?Q?lIqDa42+zDRKK1f5zKZ3OeGYDxgmQrMm4IGaRZSdeTH+pSqddjNbXWI4?=
 =?windows-1255?Q?WIRC0EJdlZ+oiRMBBazwkF45SWwDBSok1YHw45fsFUQRtdgggJ7hGcum?=
 =?windows-1255?Q?14jUJsK72U0pNfsVek0qJEtz0bVtKbDQ6djkvvVc/JqllqPmkNhyjjO9?=
 =?windows-1255?Q?iCBzAt1mQ25+bQ2CgGV69amuZoyME56zVu9TgLtR667/JwwXS/lyp4WN?=
 =?windows-1255?Q?dNdpRdTIfOvXYZhg+ysh2Y6sQd/h+FoLGfWsOISSTKeyJGvvMf6XON2h?=
 =?windows-1255?Q?RyKx6JCtbgoRGcW/0eLmUwBuANo9xGG8W+CbbXgIkLS3qi9TXna2g/ck?=
 =?windows-1255?Q?+MIcNBn1hfq/OArIylOigS0f2pHAXxcfWRHokk0lubl92SzCc3Xvhxx1?=
 =?windows-1255?Q?jqza+oV1cy6nThupbvx6JDvC/19E1bIDqMnhr4vhyKY/w7OzZ5J+wUdy?=
 =?windows-1255?Q?vWgW0Q8lCHgeCc3MPfWsYQT7Bwuva83V/f9OsLtGz+1JDQt7GtErWDar?=
 =?windows-1255?Q?g+H8ZJ+xnFj+LxP91n6M85irVa8=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?windows-1255?Q?bC95oErQH8fyhQ1Um41OHakvQjgIFHc4zlwBV8eSMIHmjbv2ndjBmIYO?=
 =?windows-1255?Q?okBjEEOiDHkV2Ftm37csF7edRn5YIjj+ILphwtjVNf6cEI+FFeHj//U8?=
 =?windows-1255?Q?N0guJNJUAQcQhcaoZ6kISLEdsjB9KBITc78CD7OCPPTDmJOPvESFsJLN?=
 =?windows-1255?Q?kGE2L0hrisJCOMH1vlXtd/hkbpneRflQQDFfvjZRVsWrpTyR/PyFOfBg?=
 =?windows-1255?Q?rjFkpxNUH8xBR25iEgRXSoOGkg3AZVulQ0ojz95yy4X6v1tKU7V87Zk8?=
 =?windows-1255?Q?7KXNkGDqJ6Dvnt0dZ5noq+JPqvkTlljDoeNAmCqIp0sSjKrgEiCInZWU?=
 =?windows-1255?Q?6p3JZ4fx+SIjcO6QiuGNtcjvHgVphrJzFDUHo3J/cLPXE5KKKsNhVzOh?=
 =?windows-1255?Q?JRLDQ4HgSgsSY3lZMipZXPXTIyEh9+488wk5SDASggPviYGGI2wvFWqN?=
 =?windows-1255?Q?L/0BRav+pKt7dtiUFvqN+KWGSOaSzooDmQZMsEXgPBVHUW2e9VE5sYb0?=
 =?windows-1255?Q?WCz01ebzkghGXtgYiC1XA2ijMduSOG6BQFF3Fh1PRiCP6HIrC+SbRDoO?=
 =?windows-1255?Q?H1Z/zFRgvlC8YzXwwl7Ig4ZCIGtheDKRq4/7dQsF0NFO2GJdqsNDLBNV?=
 =?windows-1255?Q?BtN8ta7/DLW/7c/YWvANTlKc+NK4akNqFEbl1JOMTp3GN80AJSg79l06?=
 =?windows-1255?Q?oxBIYOuPfAD6yQYvvRWdQg7Js2lAESdzTB2FPn4xm6VNAE+3Q2FzhcZf?=
 =?windows-1255?Q?txCvKJX9AWZCj+1/PbQZllaMavJmc/dIMSa7hkyve6DIymcMlisRBnqm?=
 =?windows-1255?Q?WJxfIhwwd0GI16iSE9kiQSYkZFtLJziAff+E2/0RV16SLxX2kErxUEfr?=
 =?windows-1255?Q?u1xnXOa/UDEcwpkVT7OzzljI+GNrhDmhdVT6oHnlauLt6+WPAOjnD4uI?=
 =?windows-1255?Q?RyvVTh8WlBvhRY/Ksy00nPOid9baaXdq67YTFQu2s/bdeVVDclWWi0rU?=
 =?windows-1255?Q?pgJ/eusckWX+MTFqrMSNsoxYDma/dsj1IL7LhbXfeX8eCgfBH4fJwAvT?=
 =?windows-1255?Q?oTMghe5MMtqHyTeyU7QiNX/piB8ptYZnAkz9GI2rCpwuwzh4i7Gom5+l?=
 =?windows-1255?Q?dIWQjxafgqugvK228XXmKIFILhzxJ993z6ABF3/1skxAlzQZEeJSQmLJ?=
 =?windows-1255?Q?i7dQY/F5z+VG8kYyiNE/losBhF04+u/VicR1WOlCHpCcOkHvEOLc037b?=
 =?windows-1255?Q?7occ+3fQzbzt4dfLpgTpbl8MCxG7B981mgjQGeJg6U7LjCqcC0SXFuyb?=
 =?windows-1255?Q?w7obuAPUYHOGr4zrRIiA9v0BDK6cKhm+lc91MuqwVlEgZjGFTl9OFVne?=
 =?windows-1255?Q?Gs6P41P+/qazgLlbBWEH59I51nGNUT7WatFT6n80nJtwU05rGDhYxpav?=
 =?windows-1255?Q?JbJ8NqesRvhgkLxIX3xtqA7gqsgAVOAc5AfgRiC41ig=3D?=
Content-Type: multipart/alternative;
 boundary="_000_LV5PR84MB40263D472C5CF968889420A9968D2LV5PR84MB4026NAMP_"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-4a72f.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV5PR84MB4026.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 148dc2e7-b716-41dc-b19e-08df1d25b94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 05:59:56.9327 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR84MB3545
Received-SPF: pass client-ip=2a01:111:f403:d004::;
 envelope-from=Refael-M@hotmail.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:10:43 -0400
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

--_000_LV5PR84MB40263D472C5CF968889420A9968D2LV5PR84MB4026NAMP_
Content-Type: text/plain; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

hv-balloon runs its event loop, including the receive path, from contexts
other than the VMBus channel notify callback: the QMP "balloon" handler
(hv_balloon_to_target()), the post-init timer and the open/close/reset
paths. Receiving is only legal between ringbuf_start_io() and
ringbuf_end_io(), which channel_event_cb() provides for the notify path.
When the receive ring is empty, vmbus_channel_recv_peek() returns before
seeking, so this is usually harmless. When the guest has just posted a
Dynamic Memory message (e.g. the periodic STATUS report, or the response
to a previous hot-add) and the QMP "balloon" command arrives before the
notifier runs, QEMU aborts:
  hw/hyperv/vmbus.c:418: gpadl_iter_seek: Assertion `iter->active' failed.
Seen with a Windows Server 2022 guest (Hyper-V Dynamic Memory driver),
hv-balloon with a memdev and status-report=3Don, and a host-side controller
issuing a few "balloon" commands within a minute while an RDP user logged
in (the guest's committed memory jumped and hot-adds were in flight).
Make vmbus_channel_recv_start() start the ring I/O itself when it is
called outside the notify callback, remember that in the receive ring,
and end it in vmbus_channel_recv_done() (or right away if recv_start()
fails). The notify-callback path is unchanged.
Signed-off-by: FULL NAME <refael-m@hotmail.com>
---
 hw/hyperv/vmbus.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -121,6 +121,12 @@
     uint32_t last_rd_idx;
     /* last seen write index */
     uint32_t last_seen_wr_idx;
+    /*
+     * recv_start was called outside the channel notify callback (e.g. fro=
m a
+     * QMP-triggered device path such as hv-balloon's balloon target chang=
e),
+     * so it started the I/O on the ring itself and recv_done must end it.
+     */
+    bool own_io;
 } VMBusRecvRingBuf;


@@ -1113,7 +1119,7 @@
     return req;
 }

-int vmbus_channel_recv_start(VMBusChannel *chan)
+static int vmbus_channel_recv_start_io(VMBusChannel *chan)
 {
     VMBusRecvRingBuf *ringbuf =3D &chan->recv_ringbuf;
     vmbus_ring_buffer *rb;
@@ -1132,6 +1138,33 @@
     /* prevent reorder of the following data operation with write_index re=
ad */
     smp_mb();                   /* barrier pair [C] */
     return 0;
+}
+
+int vmbus_channel_recv_start(VMBusChannel *chan)
+{
+    VMBusRecvRingBuf *ringbuf =3D &chan->recv_ringbuf;
+    bool own_io =3D false;
+    int ret;
+
+    /*
+     * Receives normally happen within channel_event_cb(), which brackets =
them
+     * with ringbuf_start_io()/ringbuf_end_io().  Device code may also rec=
eive
+     * from other contexts (hv-balloon does from its QMP balloon handler);=
 make
+     * that safe instead of tripping the iter->active assertion in
+     * gpadl_iter_seek() when a packet is pending.
+     */
+    if (!ringbuf->common.iter.active) {
+        ringbuf_start_io(&ringbuf->common);
+        own_io =3D true;
+    }
+
+    ret =3D vmbus_channel_recv_start_io(chan);
+    if (ret && own_io) {
+        ringbuf_end_io(&ringbuf->common);
+        own_io =3D false;
+    }
+    ringbuf->own_io =3D own_io;
+    return ret;
 }

 void *vmbus_channel_recv_peek(VMBusChannel *chan, uint32_t size)
@@ -1208,7 +1241,7 @@
     ringbuf->rd_idx =3D ringbuf_tell(&ringbuf->common);
 }

-ssize_t vmbus_channel_recv_done(VMBusChannel *chan)
+static ssize_t vmbus_channel_recv_done_io(VMBusChannel *chan)
 {
     VMBusRecvRingBuf *ringbuf =3D &chan->recv_ringbuf;
     vmbus_ring_buffer *rb;
@@ -1266,6 +1299,18 @@
     ringbuf_unmap_hdr(&ringbuf->common, rb, true);
     ringbuf->last_rd_idx =3D ringbuf->rd_idx;
     return read;
+}
+
+ssize_t vmbus_channel_recv_done(VMBusChannel *chan)
+{
+    VMBusRecvRingBuf *ringbuf =3D &chan->recv_ringbuf;
+    ssize_t ret =3D vmbus_channel_recv_done_io(chan);
+
+    if (ringbuf->own_io) {
+        ringbuf_end_io(&ringbuf->common);
+        ringbuf->own_io =3D false;
+    }
+    return ret;
 }

 void vmbus_free_req(void *req)


--_000_LV5PR84MB40263D472C5CF968889420A9968D2LV5PR84MB4026NAMP_
Content-Type: text/html; charset="windows-1255"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dwindows-1=
255">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"rtl">
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
hv-balloon runs its event loop, including the receive path, from contexts</=
div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
other than the VMBus channel notify callback: the QMP &quot;balloon&quot; h=
andler</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
(hv_balloon_to_target()), the post-init timer and the open/close/reset</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
paths. Receiving is only legal between ringbuf_start_io() and</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
ringbuf_end_io(), which channel_event_cb() provides for the notify path.</d=
iv>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
When the receive ring is empty, vmbus_channel_recv_peek() returns before</d=
iv>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
seeking, so this is usually harmless. When the guest has just posted a</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
Dynamic Memory message (e.g. the periodic STATUS report, or the response</d=
iv>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
to a previous hot-add) and the QMP &quot;balloon&quot; command arrives befo=
re the</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
notifier runs, QEMU aborts:</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp; hw/hyperv/vmbus.c:418: gpadl_iter_seek: Assertion `iter-&gt;active' =
failed.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
Seen with a Windows Server 2022 guest (Hyper-V Dynamic Memory driver),</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
hv-balloon with a memdev and status-report=3Don, and a host-side controller=
</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
issuing a few &quot;balloon&quot; commands within a minute while an RDP use=
r logged</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
in (the guest's committed memory jumped and hot-adds were in flight).</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
Make vmbus_channel_recv_start() start the ring I/O itself when it is</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
called outside the notify callback, remember that in the receive ring,</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
and end it in vmbus_channel_recv_done() (or right away if recv_start()</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
fails). The notify-callback path is unchanged.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
Signed-off-by: FULL NAME &lt;refael-m@hotmail.com&gt;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
---</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;hw/hyperv/vmbus.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++=
+--</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;1 file changed, 47 insertions(+), 2 deletions(-)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
--- a/hw/hyperv/vmbus.c</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+++ b/hw/hyperv/vmbus.c</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
@@ -121,6 +121,12 @@</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_rd_idx;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; /* last seen write index */</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_seen_wr_idx;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; /*</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * recv_start was called outside the channel notif=
y callback (e.g. from a</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * QMP-triggered device path such as hv-balloon's =
balloon target change),</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * so it started the I/O on the ring itself and re=
cv_done must end it.</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; */</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; bool own_io;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;} VMBusRecvRingBuf;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
@@ -1113,7 +1119,7 @@</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; return req;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
-int vmbus_channel_recv_start(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+static int vmbus_channel_recv_start_io(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; VMBusRecvRingBuf *ringbuf =3D &amp;chan-&gt;recv_r=
ingbuf;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; vmbus_ring_buffer *rb;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
@@ -1132,6 +1138,33 @@</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; /* prevent reorder of the following data operation=
 with write_index read */</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; smp_mb();&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* barr=
ier pair [C] */</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; return 0;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+int vmbus_channel_recv_start(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; VMBusRecvRingBuf *ringbuf =3D &amp;chan-&gt;recv_ringbu=
f;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; bool own_io =3D false;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; int ret;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; /*</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * Receives normally happen within channel_event_c=
b(), which brackets them</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * with ringbuf_start_io()/ringbuf_end_io().&nbsp;=
 Device code may also receive</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * from other contexts (hv-balloon does from its Q=
MP balloon handler); make</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * that safe instead of tripping the iter-&gt;acti=
ve assertion in</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; * gpadl_iter_seek() when a packet is pending.</di=
v>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp; */</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; if (!ringbuf-&gt;common.iter.active) {</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ringbuf_start_io(&amp;ringbuf-&=
gt;common);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; own_io =3D true;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; ret =3D vmbus_channel_recv_start_io(chan);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; if (ret &amp;&amp; own_io) {</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ringbuf_end_io(&amp;ringbuf-&gt=
;common);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; own_io =3D false;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; ringbuf-&gt;own_io =3D own_io;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; return ret;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;void *vmbus_channel_recv_peek(VMBusChannel *chan, uint32_t size)</div=
>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
@@ -1208,7 +1241,7 @@</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; ringbuf-&gt;rd_idx =3D ringbuf_tell(&amp;ringbuf-&=
gt;common);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
-ssize_t vmbus_channel_recv_done(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+static ssize_t vmbus_channel_recv_done_io(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;{</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; VMBusRecvRingBuf *ringbuf =3D &amp;chan-&gt;recv_r=
ingbuf;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; vmbus_ring_buffer *rb;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
@@ -1266,6 +1299,18 @@</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; ringbuf_unmap_hdr(&amp;ringbuf-&gt;common, rb, tru=
e);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; ringbuf-&gt;last_rd_idx =3D ringbuf-&gt;rd_idx;</d=
iv>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;&nbsp;&nbsp;&nbsp; return read;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+ssize_t vmbus_channel_recv_done(VMBusChannel *chan)</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+{</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; VMBusRecvRingBuf *ringbuf =3D &amp;chan-&gt;recv_ringbu=
f;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; ssize_t ret =3D vmbus_channel_recv_done_io(chan);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; if (ringbuf-&gt;own_io) {</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ringbuf_end_io(&amp;ringbuf-&gt=
;common);</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ringbuf-&gt;own_io =3D false;</=
div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; }</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
+&nbsp;&nbsp;&nbsp; return ret;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;}</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;</div>
<div class=3D"elementToProof" style=3D"direction: ltr; margin: 0cm; font-fa=
mily: &quot;Calibri Light&quot;, &quot;Helvetica Light&quot;, sans-serif; f=
ont-size: 16pt; color: rgb(0, 0, 0);">
&nbsp;void vmbus_free_req(void *req)</div>
<div style=3D"direction: ltr; font-family: &quot;Calibri Light&quot;, &quot=
;Helvetica Light&quot;, sans-serif; font-size: 16pt; color: rgb(0, 0, 0);">
<br>
</div>
</body>
</html>

--_000_LV5PR84MB40263D472C5CF968889420A9968D2LV5PR84MB4026NAMP_--

