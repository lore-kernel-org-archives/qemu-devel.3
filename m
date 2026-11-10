Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F1606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iWlcLQQI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQr8n-0003OG-Om; Tue, 10 Nov 2026 14:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQr8j-0003Me-8H
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:04:17 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xQr8g-0006vl-De
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 14:04:15 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67c2c2ac1c3so3663635d50.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 11:04:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794337452; cv=none;
 d=google.com; s=arc-20260327;
 b=ph4BfUsOSxEWmfNIdi03NF6T8DlxOT7dhNlKLQ4eatQa0BK9fXMp9kIoP2trcDKt/8
 0hY+pHdE+vpo3iWp5tIDjhXES7SG9oXh6CfBF86vVsIYITHwwDxP/cSDn8OjD2XXbjIx
 07uKHnucAE4XyRzuWn3OmgBl7srDJ2Vv5xYnWbVLqmI55PLjPzkk60W39TrzyFX+BUyS
 Dj7rTiDiZKRR13I/VHweB6YRW+HY02Ooi4yhf67qOMPIzNK53ZKxmqkQlYM+JrNSr5DS
 ifXSoQ7KqbjCS/Kk9xYh+/b3JjUebK6L4rUDJuUILlPxPjlhMlvlMzX4P84wtXn1nJk5
 /7Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nsuCbnBVWreA2tp9TKJriBPwT0MLjnZXTRbXHFlE5AU=;
 fh=CKD9MpwHoNwy9R5jWqGKKqLo7NR7Fn/dVPp6V01OKoo=;
 b=YrmhDF4YjgLOW40F5EvIL7rsibQlmGsxLHnQzDw3/RMbFBZ/dTKsdbB0t91edwLj+A
 nPrHAuUIPrK8K0cICRZdcEXpJVv/5N9baCSkSb2+h1hYM0T/tixdz3rjUgRwJfub/qHf
 3Z4HDx+NxEIvvoZ2OmS/p8/VqoF/6VWK7nPzHSFmR6iN+t/q8LS7N8J+8JmjzBqZ+AaL
 zQ0eMGDjZUtAs0RfaLZV74Xe9/L7y4H6Rguwb5C4R7MbiX4xTNUiCIsWIJHuIQR4Q40M
 gKZoEbvajJ5l5yQeR4l0vQp11/7I2YjmK2UD3Aa67xJvZ8CrNjmDgFuNoUGdqqkKYJpV
 ggAA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794337452; x=1794942252; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nsuCbnBVWreA2tp9TKJriBPwT0MLjnZXTRbXHFlE5AU=;
 b=iWlcLQQIj9WI7/TK3oGQlSOPr9bg9sDMFQwXv+QdkXRVVDxj/rm9ngxKf18NcXtTrd
 3/Ss+SUgllDKJP3OzcOvSGRnONTAvEJSHLxsjNLJbybFJpPXSX0fX6cEGz0Rpj+Z01Sp
 uxdR8IwvSoQq73AtsFnAAs9bDNKCIjEP2y9ROvPIIPamnGLqV0ECvGAlGgff4zygZ43J
 i4DkuATVnhICF5wItQxKI+I05ANTNDEi6P3zcntmG/gSRKXiu/NlNsCS6LivuMYq3b2T
 WtYw0SMl8yhsRzN7n50jLblxxO4AjB6x82ICLXagNVzrRFYmiKFiNhas7K9dJO6SCPXD
 zXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794337452; x=1794942252;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nsuCbnBVWreA2tp9TKJriBPwT0MLjnZXTRbXHFlE5AU=;
 b=NNbji+xuWqcr9f6mqmz90EkvpFt69K9RvzMoiuCzO0K17X3YAgzKcV9Tip1IGZBgUO
 x8TBi6Rq60GS07DXoTclRfmjeXxzTBxIB6r8Ev+mnXcOI9TaT4jczfN6Q+ngzasr7bWk
 kJGvcaC9nQjYARgwaM0lbE3eAvbRHZU+suk2nT1rsh6yCbfx4LmwGYB4eH9fKlDWKayZ
 dAv9EcFz/Db4+2jB03Jsa7X4bWZ+zIky1ds+hndnodfoHnFaKkQVVFzikBRdTN104Zpx
 v1qWcUe2VLDk572SjJaaKSpAy8OIN1Q7lBCaUJko99VjEutoG3MkkNqQJHngwwi/SasA
 R36Q==
X-Gm-Message-State: APuU4Z/kqqyf/drP2jwKGJd3yWV9TDQLfgXNti+HnYi1pcHftFeiH/0h
 VLsPLpfE180Iq+RfTdY09sl/1A36mDv3crIm7PYzwR44yk/l4tn2ZKif4n+KGm0JhWYQcV0BJfp
 snn3mzzL+tFDx5RNNJmw8VjvMmlioclzNvkiJ5iLQ6A==
X-Gm-Gg: AYBFou2IsG6meullqLcOHgNF3iJ6kCla+2v2So4WbOmJbL7gNPRmSyUEWj0UlYac4v6
 bnsyGb5XTjeCzW67uTRJoWTx6sfDlNjoEtHRdZMpCHDwfp1IuzuoW1i8kk+6rAjIZESANDn04VZ
 u/tRS7yI8ZtCz2fXCfg1RY8VGTciW33GCJoCfWqphIX6skE84lwbxH9Mxpnz3zlDDJn4jjdVNWy
 FR/476Ign6Xa8rXtU7rCGtm9fzypdGHgCBRxgtHw8cr4cwQqSMys2iH8mxZf+V76XAGnnGiQ9Vj
 JxaandGGlxgLBGf66y1xx3tE/LElORekTkJu5ueujy+Vc1+IZY3A4Zkr4DvvCAU1Z+qzm6vOvhV
 ZW1qIJCr3HVnBeUFw3xvokN/S3GzNxpQl+NFUemRLvEEnHoXUH2aac+6eJp3pMr8lgVrWf2pn3r
 ZhDN/Vcyx9Mf0yhHB6BSWn
X-Received: by 2002:a05:690e:408b:b0:67b:ea15:ece8 with SMTP id
 956f58d0204a3-67c680320c2mr160722d50.101.1794337452377; Tue, 10 Nov 2026
 11:04:12 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103143516.2182626-1-peter.maydell@linaro.org>
 <auy6eFKcQOvGWpyi@redhat.com>
In-Reply-To: <auy6eFKcQOvGWpyi@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Nov 2026 19:04:00 +0000
X-Gm-Features: AclHuK890royj60KVO2vNhV7rzI0oM8NP_vq_aeWfw3S6SsNZrwtmJCmLnkbt0I
Message-ID: <CAFEAcA-eaeTyi7vBb9A9ok7GZJrKLfCO9tepoTqa+0BppathxQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] block/vmdk: Fix various bugs in handling malicious
 image files
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 5 Nov 2026 at 17:18, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 03.11.2026 um 15:35 hat Peter Maydell geschrieben:
> > This set of patches fixes four reported bugs in vmdk's handling of
> > potentially malicious image files:
> >
> >  #3843: if cluster_sectors is 0x200000 we can overflow an 'int' and try
> >         to g_malloc() 0xffffffff80000000
> >  #4017: if cluster_sectors is 0 we will divide by zero and SIGFPE
> >  #4029: we can overflow a 32*64 multiply; we catch it a bit later on
> >         so there are no ill-effects, but for robustness it's better to
> >         check before the multiply
> >  #4571: we can read off the end of a block of memory when trying to
> >         parse descriptors; worst case is that we read some junk from
> >         the heap into BlockDriverState::auto_backing_file and
> >         ::backing_file. I don't think this is an exploitable info
> >         leak into the guest.
> >  #4571: if the input file specifies no extents, we hit an assert
> >         in vmdk_co_get_info() rather than rejecting the file
> >         (mentioned in passing in the same issue as previous bug)
> >
> > I think these all classify as "hardening bugs" rather than security
> > issues, since they're just "self-denial-of-service" at worst.
> >
> > Tested using qemu-iotests on the vmdk format.
>
> Thanks, applied to the block branch.
>
> It would have been nice to add new qemu-iotests cases that can catch
> these bugs, maybe you still want to do that on top?

I had a look at this, but then re-reading the bug reports I kind
of lost the will to continue trying to dig through the AI generated
report slop to try to extract something resembling a repro case
that could be put into the iotests. I'm also generally dubious
about the utility of adding regression tests for "we do something
wrong on this specific invalid input" because it seems unlikely to
me that we reintroduce the same bug again.

The one that was reasonably doable was the "no extent lines" bug.

diff --git a/tests/qemu-iotests/059 b/tests/qemu-iotests/059
index 49c58ad05c3..79fd4de1e7e 100755
--- a/tests/qemu-iotests/059
+++ b/tests/qemu-iotests/059
@@ -100,6 +100,18 @@ RW 12582912 VMFS "dummy.vmdk" 1
 EOF
 _img_info

+echo
+echo "=== Testing malformed VMFS with no extent lines ==="
+cat >"$TEST_IMG" <<EOF
+# Disk DescriptorFile
+version=1
+CID=fffffffe
+parentCID=ffffffff
+createType="vmfs"
+
+EOF
+_img_info
+
 echo
 echo "=== Testing truncated sparse ==="
 _make_test_img -o "subformat=monolithicSparse" 100G
diff --git a/tests/qemu-iotests/059.out b/tests/qemu-iotests/059.out
index 275ee7c7781..56bdc085862 100644
--- a/tests/qemu-iotests/059.out
+++ b/tests/qemu-iotests/059.out
@@ -2040,6 +2040,9 @@ read 512/512 bytes at offset 1063004405760
 === Testing malformed VMFS extent description line ===
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Invalid extent line: RW
12582912 VMFS "dummy.IMGFMT" 1

+=== Testing malformed VMFS with no extent lines ===
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Invalid file: no extent
lines present
+
 === Testing truncated sparse ===
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=107374182400
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': File truncated,
expecting at least 13172736 bytes


thanks
-- PMM

