Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C341C83F1B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 14:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZsAw-0002y0-37; Thu, 10 Jul 2025 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uZs08-0001fp-5n
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:11:52 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1uZs05-0004Sh-I3
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 10:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=8tF56U9L9VOIlvzuB4BsGnOTd3FFf0iz5iF0JfPUG5k=; b=r78/8xJiujelNgRdX9rmGoOyh+
 IeqgBaeaenvJYQflmCGzOaix72dbl8/VYQWx8LXSioVZgflc0TtXj7gk+32d5gbnLj0TxLYlY7OuI
 OSTAPaxvOuA3Dos8Xv8wMYHxbpKeh/+8Iqi0pZ2FkGLwzwHO2E0W5fSRaKyyVUIpn2RLuhatq2K/N
 aWbI9LsUE1RX+hvKzoJpHHEllMWXH7AV3Qd8qpOMbg70xRtksb/ioD12gdVFngRaKsntffLRXviId
 +qWjcy6Yhfnp4vgX7k+953OYKYgGVFd2T5wRFJIn5xqd3LuReJr/K5xmXg7erQzylytjCHn2OypAB
 hpy+vwJVk99LPNlYE2kdKt3uVutvdgwqpSMX9X9lQtuq/PgdGbh9dXBkWRDMQJkfV/d4TUiK+JpCy
 raXW4loTYKtOjl2nYKEuDuyBSAy8BC021DH/hbB3hUeIio9VSyNRcIV3WcIFPuRg4/ez4hmkPKNnl
 9AklW039wuT/y7xvx5SVq3WY7TPjulW2cOETnRY4272WFZErheaJzwN3uoxZbLu/2pmFxaRTGKb/B
 gN2QR5LW6Sj0wPsMZEiE2S7RpQXUjUFs7O7YeYGj5QlFxS4mdUo3bEDH7Og/e+TD8xUpTG6BRuauX
 TyUEO9u4mQr4fvRyWuF04vWr6vxZT8Gb3mgEdPnDE=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PULL 7/9] tests/9p: add 'Tsetattr' request to test client
Date: Thu, 10 Jul 2025 16:11:44 +0200
Message-ID: <1956976.W3UK9cqU4Q@silver>
In-Reply-To: <CAFEAcA8Sc7t25KNzwnEAi=n8SNCAYDsFbs8P8hUKwWRxWzx_QQ@mail.gmail.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
 <4719a2d59176a6c850e2b4f1af44cecd25430fce.1746438650.git.qemu_oss@crudebyte.com>
 <CAFEAcA8Sc7t25KNzwnEAi=n8SNCAYDsFbs8P8hUKwWRxWzx_QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thursday, July 10, 2025 3:30:22 PM CEST Peter Maydell wrote:
> On Mon, 5 May 2025 at 10:54, Christian Schoenebeck
> <qemu_oss@crudebyte.com> wrote:
> >
> > Add and implement functions to 9pfs test client for sending a 9p2000.L
> > 'Tsetattr' request and receiving its 'Rsetattr' response counterpart.
> >
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > Message-Id: <20250312152933.383967-6-groug@kaod.org>
> > ---
> >  tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
> >  tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
> >  tests/qtest/virtio-9p-test.c          |  1 +
> >  3 files changed, 84 insertions(+)
> >
> > diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
> > index 98b77db51d..6ab4501c6e 100644
> > --- a/tests/qtest/libqos/virtio-9p-client.c
> > +++ b/tests/qtest/libqos/virtio-9p-client.c
> > @@ -557,6 +557,55 @@ void v9fs_rgetattr(P9Req *req, v9fs_attr *attr)
> >      v9fs_req_free(req);
> >  }
> >
> > +/*
> > + * size[4] Tsetattr tag[2] fid[4] valid[4] mode[4] uid[4] gid[4] size[8]
> > + *                  atime_sec[8] atime_nsec[8] mtime_sec[8] mtime_nsec[8]
> > + */
> > +TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt)
> > +{
> > +    P9Req *req;
> > +    uint32_t err;
> 
> 
> Hi -- Coverity warns (CID 1609751) that this function
> passes by value an argument which is a 184 byte struct.
> Is this intentional?

Hi Peter!

Yes, that was intentional. It follows the same coding pattern of the 9p test
cases to hack named function arguments into C:

  someFunc({ .argC = 3, .argH = "foo", .argX = 1 });

That saves a lot of code and makes callers better readable, because some test
case just needs to pass a value for argument A and C, another test might need
to pass arguments H, X and Y, and so on.

Before we had numerous function variations for the same thing, just with
different argument permutations. Now it's only one function per purpose.

> Can we instead pass a pointer to the
> struct?
> 
> This is only a test program and 184 bytes is not super
> enormous, so if this would be painful to avoid we can mark
> the coverity report as a false positive.

Well, it would be possible to change this to a pointer, patch below in any
case. Personally I would just mark this as a false positive though. It's not a
bug and the resulting binary would probably be identical. No hard opinion
though.

/Christian

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 6ab4501c6e..f0b009645d 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -561,35 +561,35 @@ void v9fs_rgetattr(P9Req *req, v9fs_attr *attr)
  * size[4] Tsetattr tag[2] fid[4] valid[4] mode[4] uid[4] gid[4] size[8]
  *                  atime_sec[8] atime_nsec[8] mtime_sec[8] mtime_nsec[8]
  */
-TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt)
+TSetAttrRes v9fs_tsetattr(TSetAttrOpt *opt)
 {
     P9Req *req;
     uint32_t err;
 
-    g_assert(opt.client);
+    g_assert(opt->client);
 
     req = v9fs_req_init(
-        opt.client, 4/*fid*/ + 4/*valid*/ + 4/*mode*/ + 4/*uid*/ + 4/*gid*/ +
+        opt->client, 4/*fid*/ + 4/*valid*/ + 4/*mode*/ + 4/*uid*/ + 4/*gid*/ +
         8/*size*/ + 8/*atime_sec*/ + 8/*atime_nsec*/ + 8/*mtime_sec*/ +
-        8/*mtime_nsec*/, P9_TSETATTR, opt.tag
+        8/*mtime_nsec*/, P9_TSETATTR, opt->tag
     );
-    v9fs_uint32_write(req, opt.fid);
-    v9fs_uint32_write(req, (uint32_t) opt.attr.valid);
-    v9fs_uint32_write(req, opt.attr.mode);
-    v9fs_uint32_write(req, opt.attr.uid);
-    v9fs_uint32_write(req, opt.attr.gid);
-    v9fs_uint64_write(req, opt.attr.size);
-    v9fs_uint64_write(req, opt.attr.atime_sec);
-    v9fs_uint64_write(req, opt.attr.atime_nsec);
-    v9fs_uint64_write(req, opt.attr.mtime_sec);
-    v9fs_uint64_write(req, opt.attr.mtime_nsec);
+    v9fs_uint32_write(req, opt->fid);
+    v9fs_uint32_write(req, (uint32_t) opt->attr.valid);
+    v9fs_uint32_write(req, opt->attr.mode);
+    v9fs_uint32_write(req, opt->attr.uid);
+    v9fs_uint32_write(req, opt->attr.gid);
+    v9fs_uint64_write(req, opt->attr.size);
+    v9fs_uint64_write(req, opt->attr.atime_sec);
+    v9fs_uint64_write(req, opt->attr.atime_nsec);
+    v9fs_uint64_write(req, opt->attr.mtime_sec);
+    v9fs_uint64_write(req, opt->attr.mtime_nsec);
     v9fs_req_send(req);
 
-    if (!opt.requestOnly) {
+    if (!opt->requestOnly) {
         v9fs_req_wait_for_reply(req, NULL);
-        if (opt.expectErr) {
+        if (opt->expectErr) {
             v9fs_rlerror(req, &err);
-            g_assert_cmpint(err, ==, opt.expectErr);
+            g_assert_cmpint(err, ==, opt->expectErr);
         } else {
             v9fs_rsetattr(req);
         }
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index e3221a3104..4b55d7a56d 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -502,7 +502,7 @@ TWalkRes v9fs_twalk(TWalkOpt opt);
 void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid);
 TGetAttrRes v9fs_tgetattr(TGetAttrOpt);
 void v9fs_rgetattr(P9Req *req, v9fs_attr *attr);
-TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt);
+TSetAttrRes v9fs_tsetattr(TSetAttrOpt *opt);
 void v9fs_rsetattr(P9Req *req);
 TReadDirRes v9fs_treaddir(TReadDirOpt);
 void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index ac38ccf595..4397c0738f 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -20,7 +20,7 @@
 #define tversion(...) v9fs_tversion((TVersionOpt) __VA_ARGS__)
 #define tattach(...) v9fs_tattach((TAttachOpt) __VA_ARGS__)
 #define tgetattr(...) v9fs_tgetattr((TGetAttrOpt) __VA_ARGS__)
-#define tsetattr(...) v9fs_tsetattr((TSetAttrOpt) __VA_ARGS__)
+#define tsetattr(...) v9fs_tsetattr(&((TSetAttrOpt) __VA_ARGS__))
 #define treaddir(...) v9fs_treaddir((TReadDirOpt) __VA_ARGS__)
 #define tlopen(...) v9fs_tlopen((TLOpenOpt) __VA_ARGS__)
 #define twrite(...) v9fs_twrite((TWriteOpt) __VA_ARGS__)




