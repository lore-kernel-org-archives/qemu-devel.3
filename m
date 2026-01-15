Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3DDD44C56
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 14:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgOJ8-0003ZA-K5; Thu, 15 Jan 2026 09:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ7-0003Ym-HL
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgOJ5-0004kk-27
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 09:26:41 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so9579455e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 06:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768487197; x=1769091997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HdzmhiNbhCuoACAiWr3MI6gOjyxPmkl9tpbKx4JTUfE=;
 b=qhcZXwe6zwQZ7btnBzVbu1uvG/1ExAwqSm2n8KC5z4Dqgie1g4i3CiPhjEXrLc2qNb
 S5RfNWHI7qRwfEN+3llwFfi9dQWkRgARoiBATf1HWwynq8uBMPMZ2dyfjtiLeImSfjqg
 CrADsE9qnOxiaQ0eg0onymB/oQcO3Ots+Rjsw/IYasBRyqKojw5gW1CVIhDVTY/EW4ST
 P9vw1i6j9mN5oLkxSHCIWtE7pALPdVLH6i5ir+4fjCTtcGL8FWYGR4xtoMy0EzqlGjyz
 d3LBYQ/vCJJ1DaMFH2UgBBzXIhoXT1cKClb+2ZjcCbkiMjKrBuDYem77JaV9Il8TMq2A
 cMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768487197; x=1769091997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HdzmhiNbhCuoACAiWr3MI6gOjyxPmkl9tpbKx4JTUfE=;
 b=t3DVPOt4oWMT5tbyFVijhIAtIgR57Uh0YhHW9IV6Uin1atFe+RFZRto7cjGadU1ve1
 JHJSMstPXI3fleH+aaceuQl/X6tQvO9+mmWfIIU2L2a65GiVbn3m5Nh8wgwlELRM1109
 pug6B/INoNIrmqbP6W72KPXPj98eWOTYJzMOrT3zq8XKfYX5NbKjuQm6/PITEiVKdC1V
 GgPqBF0V86ABg8sQNI0mjD+SDc/+5klHE5ewepsbzI/US3UGxiEvHkd10Kp/tTWvb+vm
 WUCY8nGM0vmt8Vsf5x4l3jAq1Bp9mQMJKe7dl9XFYoS0Xe3Ql4KbPmT1QFAZHQYG9pTQ
 WctQ==
X-Gm-Message-State: AOJu0YwtATH0EUFGGl1VXOYmUblTa+UM3TZyEfhNo8pi5oBfIQPCz3LP
 IVxjRkdA1jEoIS/PTyEpqSkiDcBDmjrnwdHteYFuzdq0ZMqn4TVLhzDpvNisANJaZ+zhIs+63P+
 rp6Jl
X-Gm-Gg: AY/fxX7jM1gzOlhKqytCbOYtC878H7a7cHy9evuQAxENtPGeGy8kim6LRvwJGVuAV2F
 uD59MAEwaTQlphrxhIWbRCgh0EkT+jCiaLNa460zsJ+rnbAK/F7jxDVQN17rw8d13LDUeV15pkM
 rMvPpUbvnI6QrNFF0Kq7ZOHKJhzCCilN616M7mrlBJHirYOBO4TADAPi9y9p6b5H37ivSiS4K6a
 QFigHEhqF636t47L9JRLWmEu3H7dkVkFz5gKDTY+DrL6h0vz3z6+2+uBlBwIULJ8us2O8JnFooO
 vDUPNvSfbHqBCl6ySEePefJANHqiWw8HDRR08L1jA9PwQCZd+6PDp5W622sfU+52vBVKudqw6Vx
 JEV3zUjM0aqfsyVNXPYbOwE4BIsw7giUzDEZV53KVLLCj+1WTrtP4H7SxI7a15oWNum/zR5ebDh
 HPS5TLC+bf6O/YwwSkBPOMHUeWlHuGBGgBFBY6N/pDrMpvu8e+PFps9LijFDhSE4jbN0kaiYzhP
 Yq/4k+y/lk0E9K2ClQyOBz1wIjdsvPCE+QoeW0YMIXnpw==
X-Received: by 2002:a05:600c:548c:b0:477:fcb:2256 with SMTP id
 5b1f17b1804b1-47ee3371876mr85492845e9.17.1768487197336; 
 Thu, 15 Jan 2026 06:26:37 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f4b2672d6sm50759435e9.14.2026.01.15.06.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 06:26:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 4/4] qemu-options.hx: Improve formatting in colo-compare docs
Date: Thu, 15 Jan 2026 14:26:29 +0000
Message-ID: <20260115142629.665319-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115142629.665319-1-peter.maydell@linaro.org>
References: <20260115142629.665319-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The colo-compare option documentation has some formatting issues: it
uses a "@var{...}" syntax which is not used elsewhere and which is
rendered literally into the HTML documentation.  The bare "@" sign
also results in an unintended 'mailto:' hyperlink.

Rewrite this into the style we seem to use most in the rest of
the command line options, where an option which takes an argument
is written as "my-option=<thing>".

We take the opportunity to make the documentation a little clearer
by splitting up the long paragraph and using preformatted-text
markup for the names of the suboptions.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
As I don't know anything about colo-compare, I may have
accidentally introduced errors here; please check.
---
 qemu-options.hx | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index aca9dba8b9..3883afb484 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -5972,22 +5972,31 @@ SRST
         stored. The file format is libpcap, so it can be analyzed with
         tools such as tcpdump or Wireshark.
 
-    ``-object colo-compare,id=id,primary_in=chardevid,secondary_in=chardevid,outdev=chardevid,iothread=id[,vnet_hdr_support][,notify_dev=id][,compare_timeout=@var{ms}][,expired_scan_cycle=@var{ms}][,max_queue_size=@var{size}]``
-        Colo-compare gets packet from primary\_in chardevid and
-        secondary\_in, then compare whether the payload of primary packet
-        and secondary packet are the same. If same, it will output
-        primary packet to out\_dev, else it will notify COLO-framework to do
-        checkpoint and send primary packet to out\_dev. In order to
-        improve efficiency, we need to put the task of comparison in
-        another iothread. If it has the vnet\_hdr\_support flag,
-        colo compare will send/recv packet with vnet\_hdr\_len.
-        The compare\_timeout=@var{ms} determines the maximum time of the
-        colo-compare hold the packet. The expired\_scan\_cycle=@var{ms}
-        is to set the period of scanning expired primary node network packets.
-        The max\_queue\_size=@var{size} is to set the max compare queue
-        size depend on user environment.
-        If user want to use Xen COLO, need to add the notify\_dev to
-        notify Xen colo-frame to do checkpoint.
+    ``-object colo-compare,id=<id>,primary_in=<chardevid>,secondary_in=<chardevid>,outdev=<chardevid>,iothread=<id>[,vnet_hdr_support][,notify_dev=<id>][,compare_timeout=<time_ms>][,expired_scan_cycle=<time_ms>][,max_queue_size=<maxsize>]``
+        Colo-compare gets packets from the chardev backends specified by
+        ``primary_in`` and ``secondary_in``, and compares whether the payloads
+        of the primary packet and the secondary packet are the same.
+        If they match, it will output the primary packet to the chardev
+        backend specified by ``outdev``; otherwise it will notify COLO-framework
+        to do a checkpoint and send the primary packet to ``outdev``.
+
+        In order to improve efficiency, we need to put the task of comparison in
+        another iothread; the ``iothread`` option specifies that iothread object
+        (which your commandline should create).
+
+        The ``vnet_hdr_support`` flag tells
+        colo compare to pass the vnet header length when it sends and receives packets.
+
+        The ``compare_timeout`` option sets the maximum time that
+        colo-compare will hold the packet for, in ms.
+
+        The ``expired_scan_cycle`` option sets the period of scanning expired
+        primary node network packets, in ms.
+
+        The ``max_queue_size`` option sets the max compare queue size.
+
+        If you want to use Xen COLO, you need to specify ``notify_dev`` to
+        tell colo-compare how to notify Xen colo-frame to do a checkpoint.
 
         COLO-compare must be used with the help of filter-mirror,
         filter-redirector and filter-rewriter.
-- 
2.47.3


