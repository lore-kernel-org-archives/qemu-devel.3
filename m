Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7D6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AwCWpK57
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBoD-0000gi-Ak; Fri, 23 Oct 2026 05:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xKBoB-0000gH-3L
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:43:31 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1xKBo9-0008Qc-EE
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 05:43:30 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab2ad719so1048957a12.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 02:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792748608; cv=none;
 d=google.com; s=arc-20260327;
 b=BcqmWdfmyNhUUy4Di9VVq0Xd0BerdG53Y7+3ZhoMhlo8g4GQMORJZuQmL4CqIhpGVz
 u/5RT86U0C98rVqWspsZo7qaNjTW1TW9e9PyONnKJ1IMQx4/+8yuM7SU2pXDD9ScR7ho
 c83IemPUOCDJRlXMbBxi93azb99rA8faExWQiNGnGlF7GMOTaks1kEECct5nlBx7V/xP
 U0pvnnfXyRrncSePIj+O/4/nGBLvTK9TUTRFaP1W0Skc/l9+qujfDt472R3ZuRTGNRHz
 N3egxTjc7Osg3FrFDUaOiU85JKchH5rsQWct8OC+p+gmDMEPrJ9f2Eofsg54Cx0K83yq
 DHjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HZpmGHJcnt8GIm9cMIqDgm2G/8ZrQAlyZ2eYzVf2Xhw=;
 fh=oR6KT4T9R4DzEe393lAnUFWLAI2XD1MXqDS3E+1BJZc=;
 b=QDpz2ij0EkUx3jXL7FeJlLM+tLdU2tGYF9KPjQQqhsBbMdXYo4WLg6ijepeUNmFFX8
 3wVNXaGDETYtfkqlvxtaE7+NHUvptzKFD1fChF6in3q3/R5W26EfzzJt9yeYmEKGbvXJ
 Av0YLruSJ4tAAuhUv+9kSI2hOm2Rhp1QbxahbHTNcR9EGLoNtQ97CBE/Z3+hqAcms+Ou
 JSgIkuHv3m70Lv9NE7gms3lmxzrXlj8bwDpbTVLeIIsAf8zJHQDJf/xNZgGY1LJY+6VT
 /AGMxOXDyHAILJOUXLUWKFaPE9Y3FEHrxcSIzNBVH/0aihz0zq34V3B/AagzuaNsYaXs
 +lJg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792748608; x=1793353408; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HZpmGHJcnt8GIm9cMIqDgm2G/8ZrQAlyZ2eYzVf2Xhw=;
 b=AwCWpK57oi0bA5GODFsAAdvM3poQauIXMnv8B9jSAmxV+5YGoBrnyNw1EBKOOpuBwo
 wrgkxQkKWsW6vJ/H05kIlfFfX9Io8iu933qaPz424OxGAADyzuBxqUelRuj0a2XbU1aA
 QEdQ/+Ati5r3y3Ks1OOWUPg9VkTB7LGbUakGVy9ZJlkAB/2u5slbQa4OF2Nq/1gT6CRX
 CdGXKV3ZpxFT2WZyQpVbGG0pwH04717G91AUHnXzPFt5+XbqhW+bHObnaNr5sO0ud9ef
 sqF//ZOYc7Kj57CCu8HQkWIY9+EkA3C75/MqCEcjU1ebwVBU74N/uPz0Ac1DqTNCY7NB
 DsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792748608; x=1793353408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HZpmGHJcnt8GIm9cMIqDgm2G/8ZrQAlyZ2eYzVf2Xhw=;
 b=u2hW2voykKG1t2+NpvX7VkMM8IOSMRX1XR0jTjxxHvMinj2XLRPXsA3kXlRruyxFkD
 kMXL/XC8P+2sL1/p4wzQBaXwhuYDJEQz5tmv5FQiVXDrGituGEkxQ4x7GVdFn6FLwiu8
 KulDsfkplOQA7CRaRkBhCNjMG0eadHMb0Mqe9g+NxgFRwdfG0/BWr0X37f+Xac2kNR3Q
 p5ruSFMQALGJaT9jVyqGTxSxlXopZThVagoCABz7IxZT1VXFXWFn/Sxii88Om2njjT5+
 nRBXmE7EXV7brmv0GC+yiw0B4aSy6238/pn60nzUpPml7j8QuaN5IUh8FtqlLN/SCXSY
 sPXw==
X-Gm-Message-State: AFq9FYJP2C+5p+BSmbWX2sqLBKY/pWzaSTb4c9g2T3C8CBHhq7r4bPfX
 Z0hJXqBCNdXk8bRfUqnX36cLPq+/ZuunJy/1wFVS/IVZ9JE63YeCiV8gZJJ5VTG8t/ebK51w1jH
 VCdLHJFTKQtkul4xkDVaa2ywqeQa5Wk8=
X-Gm-Gg: AYBFou3gVKO3c53QDQaE9KP0SetxqiG/uimZrVmcF7d5YaShWdFh/Ra9eWuwfF21Upc
 dcxXzrYyCNaBF0/2lMJQk+UAiMhT1sdgUXwW+VLakaSrw3EgN6cwkGyBS87wGtKhN+EPfX5GzJi
 p8ahdqjeBy2aCpcYT4KAN3RmSsqNFgjSqbq+UYFgYuJbetDfcEMR8fuqW2mBU5UQp842clKAIqn
 JkTqppTuIwGHV6ATm6de5Y8TXXb1LQcRwCc6nxvYC1pzmjnOISZRADFH+VCMdZNZMogGOXZCrMM
 gVfwsJwNUe6HumhJF+LdOJT+IISf1TMKbsopq8j7bb4Ms0gcGYocNXXM/Q2BJ278k+wgxURdCWL
 IYNYI5lRab1PzMlvzu2GeWF8GtCaRnCqvYzUNNg==
X-Received: by 2002:a05:6402:1948:b0:6ac:af5e:9eab with SMTP id
 4fb4d7f45d1cf-6b432b9342dmr2890960a12.12.1792748607327; Fri, 23 Oct 2026
 02:43:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260929084416.1600199-1-zhangckid@gmail.com>
 <20261022201643.GG20810@shajnocz.csb>
In-Reply-To: <20261022201643.GG20810@shajnocz.csb>
From: Zhang Chen <zhangckid@gmail.com>
Date: Fri, 23 Oct 2026 17:42:48 +0800
X-Gm-Features: AclHuK8B2JylRY_2mmubSmvSfTo_fcPvBMOta133hcMncIq-_bGlJ2xl8Lqf3O4
Message-ID: <CAK3tnvJRKw8XSG9aWusCouo=Z=wBs8w+4DT4a774eej9tkNQBw@mail.gmail.com>
Subject: Re: [PATCH V18 00/13] iothread: Support tracking and querying
 IOThread holder
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 4:16=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Please update docs/devel/multiple-iothreads.rst. It still refers to
> iothread_get_aio_context() instead of the new API.
>

Hi Stefan,

Thanks for pointing this out. Would it be okay to include the documentation
update as a separate patch in the next revision like this?

diff --git a/docs/devel/multiple-iothreads.rst
b/docs/devel/multiple-iothreads.rst
index a6eb046267..c184222d71 100644
--- a/docs/devel/multiple-iothreads.rst
+++ b/docs/devel/multiple-iothreads.rst
@@ -88,11 +88,20 @@ argument, which is used to check for and prevent
re-entrancy problems. For
 BHs associated with devices, the reentrancy-guard is contained in the
 corresponding ``DeviceState`` and named ``mem_reentrancy_guard``.

-The ``AioContext`` can be obtained from the ``IOThread`` using
-``iothread_get_aio_context()`` or for the main loop using
-``qemu_get_aio_context()``. Code that takes an ``AioContext`` argument
-works both in ``IOThread``\ s or the main loop, depending on which
``AioContext``
-instance the caller passes in.
+The ``AioContext`` can be obtained from an ``IOThread`` using
+``iothread_ref_and_get_aio_context(iothread, holder)``, or from the main l=
oop
+using ``qemu_get_aio_context()``. Code accepting an ``AioContext`` works w=
ith
+either event loop.
+
+The holder-aware get registers a holder and takes an IOThread reference.
+After the caller has finished using the context, release the reference wit=
h
+``iothread_unref_and_put_aio_context()``, passing the same IOThread and an
+equivalent holder. Both calls require the BQL. No matching IOThread put is
+needed for the main loop's context.
+
+``iothread_unsafe_get_aio_context()`` neither registers a holder nor takes=
 a
+reference. It is for legacy callers that ensure the IOThread's lifetime
+themselves; new code must use the holder-aware API.

 How to synchronize with an ``IOThread``
 ---------------------------------------


When you have a chance, I'd also appreciate your review of the remaining
patches that don't yet have Reviewed-by tags.

Thanks
Chen


> Thanks,
> Stefan
>

