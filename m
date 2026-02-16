Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4237E63F3F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 08:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vruKq-0007hD-Rj; Mon, 16 Feb 2026 03:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vruKo-0007gr-IX
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:52:02 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vruKm-0001S9-Kh
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 03:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=wybkDzATVjSgFifoLf+xzT32rrWvgDdV/8lDyVLAve0=; b=e+1FttWYgrht4DyCTrZwLNzcoO
 W415esbZt9rPDt6ybbVt76rsWls9Sd9wsD27kt81mKI6U+YooSwHZcxJdk2nZIEn4CgfdSOw44HsM
 HBMGbD/vsul4N2bAwPe+i1fuCQ8dw5NlNq2vdLmLUrDOGZYm/aS36NoVdYHt7rgL+TxMKWi4JiMKP
 kgKPVPoY/qqs6GYGtrUdoXGopnzOXFtJSUAuRG0+xwbXzdtb5ud+xbfHJfbH79IyMBLJfUb/EZ/1B
 014s407SOo7RDgtZ/2Iox5WIpTJT7oKXjFIPyf3bJGW0d7YL104Rwar5SwiitmCueOpQWt041zkbz
 evuOatOdrsgHf7vJK7jM+7tkJhJMTDHGDdlYy6LmvliOaNj/UL6iWFdoQCKriOWxHESnXkuE0TJ55
 EUhaZIF+aNx0IWLGg3/zevciIqCYpZ+iR4sU3TeIL7asI3x/gOaewA+R/ATrPs73sowo3mVD0V9HJ
 xur2KUHYYG6O+drg6D9tkHgRooUMS2T0CtpvSoEV/oe0xKiyM1NW0qZZvTOVTfe4QSOPv1VjmA+cN
 Mq/lgejnhMpvAi7MD5FJRXYlrdcdf0liio+t3l9K2/0HFBg1ypGIi9ISkZsbrJx4TMlUbEZedPQrC
 +LuLSmIxjMAoRUTaKmlUXXYn0DYoVgv+7oAGeChmQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Andrey Erokhin <language.lawyer@gmail.com>
Subject: Re: [RFC PATCH] virtfs: 9p: local: add default uid and gid options
Date: Mon, 16 Feb 2026 09:51:55 +0100
Message-ID: <5966987.DvuYhMxLoT@weasel>
In-Reply-To: <45a6e2d7-8909-401b-9c99-3ad3da4fd982@gmail.com>
References: <fe7665bc-5ff6-4f78-82b7-1bea853583e3@gmail.com>
 <12835278.O9o76ZdvQC@weasel>
 <45a6e2d7-8909-401b-9c99-3ad3da4fd982@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

On Friday, 13 February 2026 22:53:40 CET Andrey Erokhin wrote:
> On 11/02/2026 19:07, Christian Schoenebeck wrote:
> > On Tuesday, 10 February 2026 10:45:09 CET Andrey Erokhin wrote:
> >> (BTW, is it OK that there is no fmode/dmode processing in system/vl.c?)
> > 
> > You mean error handling of these options. Well, earlier error handling on
> > one hand might be more desirable, but OTOH it might also be more
> > complicated to be handled in vl.c than either in 9p.c or 9p-local.c I
> > guess.
> I mean dmode/fmode do not reach 9p-local.c, at least when used in `-virtfs
> local,...`


Oh, didn't notice. All parameters in general are supposed to work both with 
the long form -fsdev ... -device, as well as with short form -virtfs.

/Christian



