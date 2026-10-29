Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC11B606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dupond.be header.i=@dupond.be header.a=rsa-sha256 header.s=dkim header.b=BTqr9FrC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRaA-0007GM-TF; Thu, 29 Oct 2026 10:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xMRa8-0007Fy-Ez; Thu, 29 Oct 2026 10:58:20 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1xMRa5-00014c-U5; Thu, 29 Oct 2026 10:58:20 -0400
Received: from [IPV6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2] (unknown
 [IPv6:2a00:1c98:fff1:1001:aee7:ee9c:3ae8:78e2])
 by apollo.dupie.be (Postfix) with ESMTPSA id 557791520D01;
 Thu, 29 Oct 2026 15:58:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1793285893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IXMcP3jEl+YzHyotGKWBsZBOOFZJoAE3Y2yNiuXCb1Q=;
 b=BTqr9FrCaRPii6HUF/OdFc3zC3h6896EeNF/iSAfr9fe0bP5MVFtmEOiP+zkqnUDT4mz/d
 ZBvfEbSOota1fm4ZvZsrD53W06MnUl5f4h0n62Gu0h6V9FU/M4KT0zV6D4ajotg//NQ0r1
 EZxyVA80CndcWWOh9405w4aM5w4IOD9bnfoAeixLihifJhGWSDbeXjLjE3PZy4LeSa9ec9
 YMbWKt6fciF6aSoiJVT9OHBmnX7t9dwR7NXfn4fLdv2L15Xf89ANLzTxSh89GeOi0edtNj
 Pg0vrbkkug4kczTmSvdUrF+dj7/pok20rMfdwIgpRpQxSYfXmlJ1YjOv0GE1AA==
Message-ID: <d7b02a58-5fe7-4f60-80cd-bb9739c24d67@dupond.be>
Date: Thu, 29 Oct 2026 15:58:12 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iotests/290: add test case to check
 'discard-no-unref' option behavior
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, den@openvz.org
References: <20261027104441.830212-1-andrey.drobyshev@virtuozzo.com>
 <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <20261027104441.830212-2-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 27/10/2026 11:44, Andrey Drobyshev wrote:
> We basically fill 2 images with identical data and perform discard
> operations with and without 'discard-no-unref' enabled.  Then we check
> that images still read identically, that their disk usage is the same
> (i.e. fallocate(FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE) is called for
> both) and that with the option enabled cluster is still marked as
> allocated in "qemu-img map" output.  We also check that the option
> doesn't work with qcow2 v2 images.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> ---
>   tests/qemu-iotests/290     | 34 ++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/290.out | 28 ++++++++++++++++++++++++++++
>   2 files changed, 62 insertions(+)
>
> diff --git a/tests/qemu-iotests/290 b/tests/qemu-iotests/290
> index 341a25f96b5..152fd7c5d1f 100755
> --- a/tests/qemu-iotests/290
> +++ b/tests/qemu-iotests/290
> @@ -90,6 +90,40 @@ for qcow2_compat in 0.10 1.1; do
>       $QEMU_IMG map "$TEST_IMG" | _filter_testdir
>   done
>   
> +echo
> +echo "### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled"
> +echo
> +
> +echo "# Check that qcow2 v2 images don't support 'discard-no-unref' option"
> +NOUNREF_IMG="$TEST_IMG.nounref"

This file should be cleaned in '_cleanup()'.
Happens in test 289 for example.

> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=0.10" 128k
> +# This should immediately fail with an error
> +$QEMU_IO -c 'reopen -o discard-no-unref=on' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Create two compat=1.1 images and fill them with identical data"
> +_make_test_img -o "compat=1.1" 128k
> +TEST_IMG="$NOUNREF_IMG" _make_test_img -o "compat=1.1" 128k
> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c 'write -P 0xaa 0 128k' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both"
> +$QEMU_IO -c 'discard 64k 64k' "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c 'reopen -o discard-no-unref=on' \
> +         -c 'discard 64k 64k' "$NOUNREF_IMG" | _filter_qemu_io
> +
> +echo "# Compare disk usage of the 2 images"
> +# Don't check the exact disk usage values but rather that they're equal
> +echo "disk_usage(`basename $TEST_IMG`) - disk_usage(`basename $NOUNREF_IMG`)" \
> +     "= $(( `disk_usage $TEST_IMG` - `disk_usage $NOUNREF_IMG`))"
Shouldn't we call _require_disk_usage in the test? Otherwise the test 
might be invalid.
Also something like the following would be cleaner:
img1=$(basename "$TEST_IMG")
img2=$(basename "$NOUNREF_IMG")
usage1=$(disk_usage "$TEST_IMG")
usage2=$(disk_usage "$NOUNREF_IMG")
echo "disk_usage($img1) - disk_usage($img2) = $((usage1 - usage2))"
> +
> +echo "# Check that images are still identical"
> +$QEMU_IMG compare "$TEST_IMG" "$NOUNREF_IMG"
> +
> +echo "# Output of qemu-img map for the image with dropped reference"
> +$QEMU_IMG map --output=json "$TEST_IMG" | _filter_qemu_img_map
> +echo "# Output of qemu-img map for the image with kept reference"
> +$QEMU_IMG map --output=json "$NOUNREF_IMG" | _filter_qemu_img_map
> +
>   # success, all done
>   echo "*** done"
>   rm -f $seq.full
> diff --git a/tests/qemu-iotests/290.out b/tests/qemu-iotests/290.out
> index 22b476594fb..f790feae81a 100644
> --- a/tests/qemu-iotests/290.out
> +++ b/tests/qemu-iotests/290.out
> @@ -58,4 +58,32 @@ read 131072/131072 bytes at offset 0
>   128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>   # Output of qemu-img map
>   Offset          Length          Mapped to       File
> +
> +### Test 'qemu-io -c discard' with 'discard-no-unref' option enabled
> +
> +# Check that qcow2 v2 images don't support 'discard-no-unref' option
> +Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
> +qemu-io: discard-no-unref is only supported since qcow2 version 3
> +# Create two compat=1.1 images and fill them with identical data
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
> +Formatting 'TEST_DIR/t.IMGFMT.nounref', fmt=IMGFMT size=131072
> +wrote 131072/131072 bytes at offset 0
> +128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 131072/131072 bytes at offset 0
> +128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +# Enable 'discard-no-unref' in one of them, discard 2nd cluster in both
> +discard 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +discard 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +# Compare disk usage of the 2 images
> +disk_usage(t.qcow2) - disk_usage(t.qcow2.nounref) = 0
> +# Check that images are still identical
> +Images are identical.
> +# Output of qemu-img map for the image with dropped reference
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false}]
> +# Output of qemu-img map for the image with kept reference
> +[{ "start": 0, "length": 65536, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
> +{ "start": 65536, "length": 65536, "depth": 0, "present": true, "zero": true, "data": false, "compressed": false, "offset": OFFSET}]
>   *** done
Thanks
Jean-Louis

