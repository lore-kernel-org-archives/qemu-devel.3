Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AFBC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6Fr-0008HO-4O; Fri, 10 Jul 2026 04:06:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wi6Fp-0008Fa-1Z
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:06:37 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wi6Fl-0006Dp-Qz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 04:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=VreJrmycFIWSWJn6lOCDw08YS5UxMH+Qpk7yd/PzSDs=; b=WQgneDN+vssoSeBWIlOs8Cdb37
 FT6SzTkF6yysiuc7BvDYWDjt+DGNqHp4Atfrizn6Du06rn3z5LktA+Sc0Y25YRB99ZmEfk8JN4VVn
 p9ERVuwKEmWzNmLc8Wb4nYjvFd5bqlJ7Qs2mkrMUcF4wrLYtzFbFcPAcuOwaQ/Ntyiyf8LGt+6q1E
 AwekbyEvwUlsNKevAoE+FkHgGPvGS7GjWRZ7IulaOUu4AkJv+0N0zpNVG5q1gXWA45ec1Mj4Tu65v
 sKre1blm/5Xks3mQlp83eDUimP1vd7ekVNPuHh6Kzi8+0ktq0N5I2dCZCOocCEeilm7sUpEdHw5tu
 6MCibSNXpWSc9/8rj45sLzMvTxorN4nhXvka9iKLXoxw1IqZ3Dv/KJcupzpwq8ZVq3aQIBlf8aOkL
 2JqgUmWH13NlWEkn8/6NQI8KP76/CyfAZwAoLl6Ft/xFBIwDE4sTLPwOEKhSnAQH3/pHT7JBOoN2p
 DlZmka4wvZO4KHMCVCB1h1CuUb2fXIW+6NZfcP4QxnAVZBAViiGQzyTOHdI+9uH+EWlx8jldy0wY7
 c7HDeaIL98fro8D94/A+XsLLhL6XETh4r4itxkHGwSaJlsFDd7sQYeyETtZSsar9EZ3YuSX5SVo7D
 CFJU/a3BwWw6y7gY1lVIxvVUQhl+54iTatiYDhWXQ=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Jia Jia <physicalmtea@gmail.com>
Subject: Re: [PATCH 2/3] hw/9pfs/virtio: disable hotpluggable property of
 virtio-9p device
Date: Fri, 10 Jul 2026 10:06:29 +0200
Message-ID: <6008134.DvuYhMxLoT@weasel>
In-Reply-To: <20260710093737.4948ded4@imammedo>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <d07de8d7b33fbbdd84909c21b67156fe564dc050.1783604079.git.qemu_oss@crudebyte.com>
 <20260710093737.4948ded4@imammedo>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Friday, 10 July 2026 09:37:37 CEST Igor Mammedov wrote:
> On Thu, 9 Jul 2026 15:50:36 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > Harden security by disabling hotpluggable property, to prevent
> > issues like fixed in the previous commit.
> > 
> > Virtio-9p is a pass-through file-sharing device that provides a
> > guest mount of a host filesystem tree. Unlike block or network
> > devices, guest-triggered hotplug of the 9p device has no practical
> > use case: the guest cannot recover from the device removal, and there
> > is no protocol-level device-loss scenario as with block or ethernet
> > devices.
> 
> hmh, I'm no maintainer of 9pfs, but to me it looks like any other
> storage device.
> One should be able to unmount/stop using it and unplug
> (it doesn't really matter if unplug is triggered by guest or host side).

Guest could still unmount and stop using the 9pfs device. But why should guest 
be able to unrealize the 9pfs device at any time? What should be the purpose 
for this particular device?

/Christian



