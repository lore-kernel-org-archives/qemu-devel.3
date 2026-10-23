Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434A5606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=evIDwnCt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKG3T-0003XU-62; Fri, 23 Oct 2026 10:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3H-0003J7-Jy
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKG3F-0006kg-Tk
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 10:15:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so9781315e9.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792764920; x=1793369720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kvy2MM5e2hcnRipWz+WHnHJkgBmQLqUf/FeYHFReCF8=;
 b=evIDwnCtUUDaPc9POO/vozBiTpMEbvTGDEZRaywZlXwaWeYqf0TPE7sUsZSvygOJ61
 rZhKDn/8MbhefmnabbsFd8Kdcyb7S/pRHsj06aUn7yPQATDhQAKWFKLXhkRW5g8P9tWJ
 DVyKWODYMWdaLLRnUlk9dj6DiuViLWSQv3A15b73vLCm115Oxz+4Jxa5oT3oR3DVPoDd
 Zz3hQTg5sC+0ASIC1SCkkeub/7tsHoMNlKjGZIvi8fd0Led5RxEJfhV50sfqQZfc+nPT
 nR33TaaPEk4pgNi81uzJ6VmbZK0wOfvzAZ3+eRc10Qb+juFOzCKm0SgqB1NdMnXno7tZ
 CT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792764920; x=1793369720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kvy2MM5e2hcnRipWz+WHnHJkgBmQLqUf/FeYHFReCF8=;
 b=QVwvT/OFkQ4y9/+ZvZkQ35xXnn77bHkftQprGbcYCyyhSNWjWJHLnkR9LY7Thp/rSp
 Uoo7qNf19rX63au1S87ipZ62R4L/Z1wfAjw2k5AYGaYhBTU0i88+t/LLxHxxh7jGQWcB
 NH2dBEBJdoDgvcPdefi77NAVnSFuBG8hdLqCdEMnNupLfYkTDmhpwfsJcOEdU430/DTy
 gQvqNPOjsxQ9P0MUIcP3YJO+z4P90wPxARxiIpxaE3LStbL8Us9bGdioY/TbavJ7Lj/Z
 GeYwr32GTabKpwB+xQ9m6XSBUSciSJXFT9LzBN5OuXqBSvWDSxaVbC54+1OWkQqIMBIJ
 U2Kw==
X-Gm-Message-State: AFq9FYLJHNkva821aPKeVorRvnXyWPeUuZtHu3e4dVYXRGLT3pURuiUQ
 9IFE1ggvDrEUiD1dynH027he+IkDmed9N1ZEqlUS5idoAy8lYz8GqwJxTRNboZGLrUPoyQPtSoh
 +H3Dojmo=
X-Gm-Gg: AYBFou09COS8BDihvTICtH5gnF48RpGZ2W0d2C75gvs1G8mAmlW61aLF0SiV+QMdIEP
 n2J9HETNuEiZ5ruW9NdSpi0uuOcoVZ8ommQuZRRwd13JdsOfjtb4wqa+mUZ/Y9n7A6tOCBDRbkH
 tP+57tdZGr3W1wnv6wr/dAPpU+ZMTeZHITb8/wqu6I15ZNZcMntWZ7X76P1YXIfO8axcn6WQhox
 D44rUKzqOp7MMh8yV+Meb/AVartrizdwDetkbe8+TB97Uej033VpcIJm/dfIfSzEKeyz9t0IGwT
 EuKuxAMsPdPJSziOhP22dFB98gGAqIr79ABhZoeDL+JMjOSVTShTwzVGOPn54suNuW3H6epkPTG
 D0StiuzPakkFhGVJECH4uQcQA1o6K0/FDxzPxlNzFBN9NbJJpi7kJm9AXD4+CPA1zxBqe2PDOBC
 NXqQQLPe3NaouzPXCojPwRch5CH7jGoj8C6RU+MSoFGt0Eye54SkfJGs9IODlb6fELQGVCzjQDR
 nbRF3pC1DUGhqJZmt6rnpcZ1wgiNW9b81y6SM3eKj7oitnEV37xm+iux7b0alAM3a7fsU7864LV
 5uLl4EJ6a8LGGeuzgbgGduZiyTlBswZYHmCy0EP/5UdpyjG3wC0TYf93cm0d
X-Received: by 2002:a05:600c:3144:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4a211f0d863mr46087015e9.35.1792764920398; 
 Fri, 23 Oct 2026 07:15:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2fe31a7a4sm1310675e9.0.2026.10.23.07.15.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 07:15:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/16] include/hw/core/qdev.h: Fix where
 device_class_set_parent_realize docs suggest putting parent_realize
Date: Fri, 23 Oct 2026 15:14:56 +0100
Message-ID: <20261023141503.1397009-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023141503.1397009-1-peter.maydell@linaro.org>
References: <20261023141503.1397009-1-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The documentation for device_class_set_parent_realize() suggests that
the parent realize function pointer is "usually in the instance
structure".  This is definitely wrong, because the function pointer
is a class thing, and should live in a class struct, not an instance
struct.  Update the documentation to correct this, instead
recommending that it should be placed in the class struct for the
child class.

At time of writing, of the 75 or so uses of this function, about 50
put the parent_realize pointer in the child class struct, and about
25 in the parent class struct.  We recommend the former both because
it is the more common choice, and also because it makes more logical
sense: it's the child that knows (a) that it exists at all and that
(b) it wants to have a realize method that will mean it needs to
chain back to the parent, and we shouldn't need to edit the parent's
class struct because we want to add a child class that chains to its
realize method.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Message-id: 20261015163352.1751191-1-peter.maydell@linaro.org
---
 include/hw/core/qdev.h | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/qdev.h b/include/hw/core/qdev.h
index 8e91e2fcb08..1330e0153d4 100644
--- a/include/hw/core/qdev.h
+++ b/include/hw/core/qdev.h
@@ -953,9 +953,18 @@ void device_class_set_props_n(DeviceClass *dc, const Property *props, size_t n);
  *
  * This is intended to be used when the new realize function will
  * eventually call its parent realization function during creation.
- * This requires storing the function call somewhere (usually in the
- * instance structure) so you can eventually call
- * dc->parent_realize(dev, errp)
+ * @parent_realize should be where you want to save the pointer to
+ * the parent class realize function; the recommended location is a
+ * field named "parent_realize" in your class's class struct.
+ * (Some existing code puts the field in the parent class's class
+ * struct; this will work but is not the preferred thing for new code.)
+ *
+ * In your realize function you should chain to your parent's
+ * realize function using something like::
+ *
+ *    MyThingClass *mc = MY_THING_GET_CLASS(dev);
+ *    (do your child class realize actions here)
+ *    mc->parent_realize(dev, errp);
  */
 void device_class_set_parent_realize(DeviceClass *dc,
                                      DeviceRealize dev_realize,
-- 
2.43.0


