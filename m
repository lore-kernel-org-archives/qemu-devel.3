Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D2AC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 14:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdVWD-0007ka-FH; Thu, 30 Jan 2025 09:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tdVWB-0007k3-KO
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:27:43 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tdVWA-0000fw-1x
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=x54nmHDeaV93QivKHILpYSoeZ1XzKkOnuK2kcbeRa6s=; b=QV3pVMKvWtn7Z8GVcfs+A2N3b+
 tkK8PRDXorCmbjrBrVN+bL89dFM2whFZPWgMm7WsZyJfBGt7CT6vNrM592hZgmKu4LOfFpbtaYEXp
 IlaT4LdfY7dzB3fZ/nZp2yFOVf2Bn6SfpgPWnAQ8E6ZXawMWi+ZTThDpIdJti+Ff6qEOyqZEJcmfU
 WPAg+YvJ2+hFf26QfzXvUg/FIV5g90LCguMcixpnc9OLwrWhW1E8QyC9xdCEE++Nbe+VDKUwaeAA7
 Gb4NVKxfisw6aSAVBCuS3me5HrZgXB3LmfsTcN9W8lv2+d17N6iC0e8G9kCCswK3qVPn9iKHkQxzf
 xBF4IiwsSnjARdvzWQjNXgmQGEArp2R4rtOzFH10AmGKUw+5ZcykyGuTO8eXZl7E57JjjtcXMQHOf
 tYws1uyQeJJTXw+MUWtqHgj0rN0sU+xsPyaQD36WUy6No1kZxaVVE4skk+9wMn6RuTKZqcqiYHs4f
 XOb/KP6p4fPX7N6nOq7xX4WycsULqLHsVO3jIdjDvRqmD+Ryl4iwcaTta7YkTUpqG4MJx1YB9sTT/
 9p0iLPrmTCLl0fOlT9yLQF3VMdNR/2LCS91Vwfmyw9uVT0VOOsTyp2pNspTfWgudd5KCk4ObcIx9V
 3XUNEQs3hqOt5GlJ/JAz0AsEDYPtr4sFH5qNRw5ck=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 0/3] tests/9p: add use-dir-after-unlink test
Date: Thu, 30 Jan 2025 15:27:35 +0100
Message-ID: <14986343.0dr4gzN2n2@silver>
In-Reply-To: <cover.1736427878.git.qemu_oss@crudebyte.com>
References: <cover.1736427878.git.qemu_oss@crudebyte.com>
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

On Thursday, January 9, 2025 2:04:38 PM CET Christian Schoenebeck wrote:
> Add a test case that verifies that it is possible to do some basic operations
> on a deleted directory if 9p client opened the directory before directory was
> removed.
> 
> Unlike the previous open-unlink-fstat idiom: no fix required here. It already
> works with 9p server.
> 
> Christian Schoenebeck (3):
>   tests/9p: rename test use_after_unlink -> use_file_after_unlink
>   tests/9p: add use_dir_after_unlink test
>   tests/9p: extend use_dir_after_unlink test with Treaddir
> 
>  tests/qtest/virtio-9p-test.c | 50 +++++++++++++++++++++++++++++++++---
>  1 file changed, 46 insertions(+), 4 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!
/Christian



