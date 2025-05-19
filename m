Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB82C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 13:38:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH0gw-0002tS-Hn; Mon, 19 May 2025 09:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH0gl-0002sZ-7N
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:37:55 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH0gi-0007U7-20
 for qemu-devel@nongnu.org; Mon, 19 May 2025 09:37:54 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70900a80907so37977767b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747661870; x=1748266670; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Lg1x/XUa39YEiyrtQ2CY+KnTWbkC1Y1OKDyIW5E05M=;
 b=iP3DmqMdig4O+Bghi3u9zWD5D1LNKKT7Udigaq3XJZ2xLUsqz9/M05EqWqLkUFXoOE
 GcTstjJmrr880tpX6rPgI+XrRmeR+1z9LiBb7XHzkt0ViR679kkxmcQkRihP2rRAndIF
 gcS755XPvFyMmmuQRyPEQcgTQWkarVMi1OLIESoknN6Uf2odTDYcYPufxzUOHgoa/+ij
 FBwUPgwa2BU1byEYMq5G4Qsu1Hh2ILOxYye7Wf2b1OyncuUPa+zgGwqJJL4HP2cIrrzN
 3ucFuMnfd1SUZxskyg9fbaqKfkqabALTGfTdE65Y+SltMJ1QH7ltg4723X5o3B1gfpMc
 nKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747661870; x=1748266670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Lg1x/XUa39YEiyrtQ2CY+KnTWbkC1Y1OKDyIW5E05M=;
 b=XeNm9Cz0O8TIpghXPGgnI8u5mAVqMxm2yYOh/iM+SWO44/qOE+8s2pSpIE+APlo2FV
 kRFEdSj8NCNvRDtZH/DgJ06TrxuESMakpiugXyOHYZWoUFWQ3MqTQ3/8G3J3bNXgGc6b
 EPaGIRlDbSRFR3dDgFFPl02LlSjGCVYO4MR/CEw5wUsWgzTEoRWF7yi4yeIfcH4GV5mV
 eJJYmE204v8sP2IgLQlfloWwf490RVXkG6aD+9VhKimyZcgZSLB/c/TouMApaUsiOiFP
 VytTp7qdmuEp2EiNJ4cghBqpdoyIau9qlt76X37IqYPI4qE7uiFMvY5cbR2XBZi+ua6K
 riog==
X-Gm-Message-State: AOJu0YyrPGQkSDcu/fb6EGV+UxnMKMEf0DgwN2JlXDb5mGgUjtHQL9JT
 hCDJfFDVyPpUZZ1ZrD+D8JErg6k4EXRI863R0eg94UCy6kaDMpgJHDbjJKcQOMG4PKO+9FisdjD
 bBck6PXtbAXVcsiqqzg7HY4cvPeauZI4pOqT5MIGEbw==
X-Gm-Gg: ASbGncsgtI7Bhbyvf83hrnHkJkbAA5pO7C/mz2fMZfjqh0FNl2kQnBk1JE9FV9gy/aC
 LsZnCJVA+iBbZhsw/exm3UsnmCMxMTvG/X6tt4iWZpVUCDv2N2srIrCixppwA3job/HZG3O3tf7
 6uz0XOO26pRAU7klf/uSKI/GJDnFm6VN6vZA==
X-Google-Smtp-Source: AGHT+IHJI7tJzFCncxZi/WjKYUY9r5N0pufGTyyQBgfjJ4v6wFiQ6eQeHQOrTvorruqJhRk82S661Gn38LE+5Wfs9o4=
X-Received: by 2002:a05:690c:650e:b0:6ef:8dd0:fff9 with SMTP id
 00721157ae682-70ca7a0fa11mr172642867b3.8.1747661870345; Mon, 19 May 2025
 06:37:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250516150052.30818-1-conte.souleymane@gmail.com>
 <20250516150052.30818-3-conte.souleymane@gmail.com>
In-Reply-To: <20250516150052.30818-3-conte.souleymane@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 14:37:39 +0100
X-Gm-Features: AX0GCFvvCwra6aRptXmZos83OA-Pr0d9cK0IM235E9ciO6GebpHegyoSaGvhlLk
Message-ID: <CAFEAcA925nKoPW5HwdNUNm8a9baEufNyPosw34-rHVkBppZVxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/interop: convert text files to
 restructuredText
To: conte.souleymane@gmail.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Fri, 16 May 2025 at 16:01, <conte.souleymane@gmail.com> wrote:
>
> From: Souleymane Conte <conte.souleymane@gmail.com>
>
> buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
>
> Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>

Thanks for this patch. It looks good, so I only have
some minor changes to suggest below.

A minor thing: for a single patch, please don't send a
cover letter -- it confuses some of our automated tooling.
Cover letters are only needed for multi-patch series.

For a single patch, if you want to add notes about e.g.
changes between v1 and v2, you can put them below the '---'
line...

> ---

...here. Text here won't go into the final git commit
message.

>  docs/interop/index.rst                |   1 +
>  docs/interop/{qcow2.txt => qcow2.rst} | 218 +++++++++++++++-----------
>  2 files changed, 128 insertions(+), 91 deletions(-)
>  rename docs/interop/{qcow2.txt => qcow2.rst} (88%)
>
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index 999e44eae1..bfe3cf0beb 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -23,6 +23,7 @@ are useful for making QEMU interoperate with other software.
>     qemu-ga-ref
>     qemu-qmp-ref
>     qemu-storage-daemon-qmp-ref
> +   qcow2

I think I would put this a little further up in the
index, just below "parallels". That way it goes together
with the other image-format specs in the index list.

>     vhost-user
>     vhost-user-gpu
>     vhost-vdpa
> diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.rst
> similarity index 88%
> rename from docs/interop/qcow2.txt
> rename to docs/interop/qcow2.rst
> index 2c4618375a..2295dd4ae6 100644
> --- a/docs/interop/qcow2.txt
> +++ b/docs/interop/qcow2.rst
> @@ -1,6 +1,8 @@
> -== General ==
> +================
> +Qcow2 Image File
> +================
>
> -A qcow2 image file is organized in units of constant size, which are called
> +A *qcow2* image file is organized in units of constant size, which are called
>  (host) clusters. A cluster is the unit in which all allocations are done,
>  both for actual guest data and for image metadata.
>
> @@ -9,10 +11,10 @@ clusters of the same size.
>
>  All numbers in qcow2 are stored in Big Endian byte order.
>
> +Header
> +------
>
> -== Header ==
> -
> -The first cluster of a qcow2 image contains the file header:
> +The first cluster of a qcow2 image contains the file header::
>
>      Byte  0 -  3:   magic
>                      QCOW magic string ("QFI\xfb")
> @@ -38,7 +40,7 @@ The first cluster of a qcow2 image contains the file header:
>                      within a cluster (1 << cluster_bits is the cluster size).
>                      Must not be less than 9 (i.e. 512 byte clusters).
>
> -                    Note: qemu as of today has an implementation limit of 2 MB
> +                    Note: Qemu as of today has an implementation limit of 2 MB

If we're going to change this kind of thing: the correct spelling
is all-caps "QEMU".

>                      as the maximum cluster size and won't be able to open images
>                      with larger cluster sizes.
>
> @@ -48,7 +50,7 @@ The first cluster of a qcow2 image contains the file header:
>           24 - 31:   size
>                      Virtual disk size in bytes.
>
> -                    Note: qemu has an implementation limit of 32 MB as
> +                    Note: Qemu has an implementation limit of 32 MB as
>                      the maximum L1 table size.  With a 2 MB cluster
>                      size, it is unable to populate a virtual cluster
>                      beyond 2 EB (61 bits); with a 512 byte cluster
> @@ -88,6 +90,7 @@ The first cluster of a qcow2 image contains the file header:
>  For version 2, the header is exactly 72 bytes in length, and finishes here.
>  For version 3 or higher, the header length is at least 104 bytes, including
>  the next fields through header_length.
> +::
>
>           72 -  79:  incompatible_features
>                      Bitmask of incompatible features. An implementation must
> @@ -185,7 +188,8 @@ the next fields through header_length.
>                      of 8.
>
>
> -=== Additional fields (version 3 and higher) ===
> +Additional fields (version 3 and higher)
> +----------------------------------------
>
>  In general, these fields are optional and may be safely ignored by the software,
>  as well as filled by zeros (which is equal to field absence), if software needs
> @@ -193,21 +197,25 @@ to set field B, but does not care about field A which precedes B. More
>  formally, additional fields have the following compatibility rules:
>
>  1. If the value of the additional field must not be ignored for correct
> -handling of the file, it will be accompanied by a corresponding incompatible
> -feature bit.
> +   handling of the file, it will be accompanied by a corresponding incompatible
> +   feature bit.
>
>  2. If there are no unrecognized incompatible feature bits set, an unknown
> -additional field may be safely ignored other than preserving its value when
> -rewriting the image header.
> +   additional field may be safely ignored other than preserving its value when
> +   rewriting the image header.
> +
> +.. _ref_rules_3:
>
>  3. An explicit value of 0 will have the same behavior as when the field is not
> -present*, if not altered by a specific incompatible bit.
> +   present*, if not altered by a specific incompatible bit.
>
> -*. A field is considered not present when header_length is less than or equal
> +(*) A field is considered not present when *header_length* is less than or equal
>  to the field's offset. Also, all additional fields are not present for
>  version 2.

For references in formatted text to things like field names, function
names, filenames and similar fixed-strings, I recommend ``header_length``
(which gives monospaced) rather than *header_length* (which is italics)
or **header_length** (which is bold).

> -              104:  compression_type
> +::
> +
> +        104:        compression_type
>
>                      Defines the compression method used for compressed clusters.
>                      All compressed clusters in an image use the same compression
> @@ -219,28 +227,30 @@ version 2.
>                      or must be zero (which means deflate).
>
>                      Available compression type values:
> -                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
> -                        1: zstd <http://github.com/facebook/zstd>
> +                       - 0: deflate https://www.ietf.org/rfc/rfc1951.txt
> +                       - 1: zstd <http://github.com/facebook/zstd>

We should be consistent about whether we have the angle brackets
or not.

This is all in a fixed-width text block, so the URL isn't going
to be formatted anyway. Might as well leave the angleb rackets in,
for consistency with e.g. below.

>
> -                    The deflate compression type is called "zlib"
> +                    The deflate compression type is called zlib

Any reason to drop the quotes here ?

>                      <https://www.zlib.net/> in QEMU. However, clusters with the
>                      deflate compression type do not have zlib headers.
>
>          105 - 111:  Padding, contents defined below.
>
> -=== Header padding ===
> +Header padding
> +--------------
>
> -@header_length must be a multiple of 8, which means that if the end of the last
> +*header_length* must be a multiple of 8, which means that if the end of the last
>  additional field is not aligned, some padding is needed. This padding must be
>  zeroed, so that if some existing (or future) additional field will fall into
> -the padding, it will be interpreted accordingly to point [3.] of the previous
> +the padding, it will be interpreted accordingly to point `[3.] <#ref_rules_3>`_ of the previous
>  paragraph, i.e.  in the same manner as when this field is not present.
>
>
> -=== Header extensions ===
> +Header extensions
> +-----------------
>
>  Directly after the image header, optional sections called header extensions can
> -be stored. Each extension has a structure like the following:
> +be stored. Each extension has a structure like the following::
>
>      Byte  0 -  3:   Header extension type:
>                          0x00000000 - End of the header extension area
> @@ -270,17 +280,19 @@ data of compatible features that it doesn't support. Compatible features that
>  need space for additional data can use a header extension.
>
>
> -== String header extensions ==
> +String header extensions
> +------------------------
>
>  Some header extensions (such as the backing file format name and the external
>  data file name) are just a single string. In this case, the header extension
>  length is the string length and the string is not '\0' terminated. (The header
> -extension padding can make it look like a string is '\0' terminated, but
> +extension padding can make it looks like a string is '\0' terminated, but

The original text is correct: this should be "make it look like".

Sphinx will interpret the '\' in '\0' as an escape, so it renders this
as "'0' terminated". If you write this with the ``...`` for fixed-width
text:
    make it look like a string is ``\0`` terminated
then Sphinx will output the backslash as a literal in the output.


> @@ -377,35 +392,42 @@ Logically the layout looks like
>
>    +-----------------------------+
>    | QCow2 header                |
> +  +-----------------------------+
>    | QCow2 header extension X    |
> +  +-----------------------------+
>    | QCow2 header extension FDE  |
> +  +-----------------------------+
>    | QCow2 header extension ...  |
> +  +-----------------------------+
>    | QCow2 header extension Z    |
>    +-----------------------------+
> +  | ...                         |
> +  +-----------------------------+
> +  | ...                         |
> +  +-----------------------------+
>    | ....other QCow2 tables....  |
> -  .                             .
> -  .                             .
>    +-----------------------------+
> -  | +-------------------------+ |
> -  | | LUKS partition header   | |
> -  | +-------------------------+ |
> -  | | LUKS key material 1     | |
> -  | +-------------------------+ |
> -  | | LUKS key material 2     | |
> -  | +-------------------------+ |
> -  | | LUKS key material ...   | |
> -  | +-------------------------+ |
> -  | | LUKS key material 8     | |
> -  | +-------------------------+ |
> +  | +------------------------+  |
> +  | | LUKS partition header  |  |
> +  | +------------------------+  |
> +  | | LUKS key material 1    |  |
> +  | +------------------------+  |
> +  | | LUKS key material 2    |  |
> +  | +------------------------+  |
> +  | | LUKS key material ...  |  |
> +  | +------------------------+  |
> +  | | LUKS key material 8    |  |
> +  | +------------------------+  |
> +  +-----------------------------+

This does not seem to render as a nested table.

Probably the simplest thing is to use the "::" syntax to
keep this as ASCII art, similar to the way you've handled
the other fixed-width tables in this document.

> +  |   QCow2 cluster payload     |
> +  +-----------------------------+
> +  |                             |
>    +-----------------------------+
> -  | QCow2 cluster payload       |
> -  .                             .
> -  .                             .
> -  .                             .
>    |                             |
>    +-----------------------------+
>

>
> -Refcount block entry (x = refcount_bits - 1):
> +Refcount block entry (x = refcount_bits - 1)::

You could put ``(x = refcount_bits - 1)`` to make the code fragment
render in monospace.


> -Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8)):
> +Compressed Clusters Descriptor (x = 62 - (cluster_bits - 8))::

and similarly here.

thanks
-- PMM

