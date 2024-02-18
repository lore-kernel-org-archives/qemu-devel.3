Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098EBC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 14:58:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbibx-0005R3-QT; Sun, 18 Feb 2024 09:57:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>) id 1rbibv-0005K4-5C
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 09:57:44 -0500
Received: from mailout12.inleed.net ([185.189.50.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hc981@poolhem.se>)
 id 1rbibm-0002Og-UZ; Sun, 18 Feb 2024 09:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=poolhem.se; 
 s=x;
 h=Content-Transfer-Encoding:Content-Type:Mime-Version:References:
 In-Reply-To:Message-Id:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=j439FxdVTEt30KwY2hUimdM1SDmKeeeB8be3bZEk8w4=; b=NKe2CC/C70UJbVmYFA793CmIS7
 N/ykvMVLyOcJ9dVvZLrCdZJ/9js2R8keNADwyVhiQzv8CyPnmpGz93FXeAEEozkpznbN+UFCETqx3
 dK0Yr6C02qCm996XBJ9K8j1ifgDD/m8/sJw4QxFzppDCYgrNHgh9Qzr5VFadrSbKaHUksRGKsdGxb
 XqjTu8hSu4suSGyX2QT12po4uBNNUV6fcoGYQxw/Ro0xI0s5jIMFZxVIouvdZG3nM5cU4glUFU99W
 pF7YsLe6f9XydwUcArh5ghQtVDJql8ukgEkeH9zw7ZNTjMivbPz2Khl8foaxoYz1Tc0UKBz6Q34rc
 3eGJEYJQ==;
Received: from [213.115.245.47] (helo=balrog.lkp.se)
 by ns12.inleed.net with esmtpa (Exim 4.97.1)
 (envelope-from <hc981@poolhem.se>) id 1rbiZh-0000000AdQM-2vH9;
 Sun, 18 Feb 2024 15:55:25 +0100
Date: Sun, 18 Feb 2024 15:55:03 +0100
From: Henrik Carlqvist <hc981@poolhem.se>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: hc981@poolhem.se, samuel.thibault@gnu.org, qemu-devel@nongnu.org
Subject: Re: Ping 2: [PATCH v2] Allowing setting and overriding parameters
 in smb.conf
Message-Id: <20240218155503.7d52a2f9.hc981@poolhem.se>
In-Reply-To: <727be4d0-3c88-4d02-b3ba-82a532fad840@tls.msk.ru>
References: <ZJFv4Hq8RMVOUum/@redhat.com>
 <20230620215043.6124c450.hc94@poolhem.se>
 <ZJKiGBJNQa5Kx+Dg@redhat.com>
 <20230621201447.712ec73a.hc94@poolhem.se>
 <20230623203007.56d3d182.hc981@poolhem.se>
 <20230801232725.4cc838fb.hc981@poolhem.se>
 <20230802195356.rwibjix3bub7s7qw@begin>
 <20230803010909.723e2c1f.hc981@poolhem.se>
 <20230802231324.b5zk2kf44oqzocel@begin>
 <20230803012602.7c75df75.hc981@poolhem.se>
 <20230802233404.lnpa5owybhvbbkyl@begin>
 <20230803171256.1d39d71f.hc981@poolhem.se>
 <20230910134812.7fa3a603.hc94@poolhem.se>
 <20240217232824.3db4c9c7.hc981@poolhem.se>
 <727be4d0-3c88-4d02-b3ba-82a532fad840@tls.msk.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: henrik@poolhem.se
Received-SPF: none client-ip=185.189.50.81; envelope-from=hc981@poolhem.se;
 helo=mailout12.inleed.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.002,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Sun, 18 Feb 2024 12:30:01 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:
> I don't maintain this code, so my email is just a random comment.

Thanks for your comment anyway!

> But I did have an issue with smbd not working right due to one
> missing/wrong parameter or another, more than once.  Also, samba
> is evolving too, so it might need more parameters or less.

During the years, my brute force approach to solve issues like this has been
to locally patch qemu source code to build custom qemu binaries with the
smb.conf parameters that I want. 

> My suggestion is still the same as 10+ years ago: to ship a shell script
> which run smbd, instead of running smbd directly.  This script will set
> up smb.conf (whole thing, exactly as it is done now in the C code), and
> exec /usr/sbin/smbd with the necessary args.

Such a script would be easier to modify than changing the C sources.

> This way, it's a) trivial to modify parameters on the qemu side (easy to
> edit just this script), b) possible to see which samba version is in use
> and adopt some parameters, c) use alternative smbd, and especially d)
> allow the end-user to override smbd or config in use.

During the years, I have also seen the need to use alternative smbd. I have
then solved it by having the old smbd that I prefered for qemu in /usr/sbin
and moved the "original" smbd provided by the Linux distribution to
/usr/local/sbin where it has been started by any real Samba servers in the
network.

> The best, I'd say, is to allow to specify the script on qemu command line
> (like samba=/etc/qemu/run-smbd.sh), and have default value for that, like
> /usr/share/qemu/run-smbd.sh, which is the default script shipped with
> qemu.  Or maybe let qemu choose to use either the one specified on the
> command line, /etc/qemu/run-smbd.sh if it exists, or
> /usr/share/qemu/run-smbd.sh.

Yes, by specifying such a script on the command line it would be possible to
have different parameters for different qemu sessions.  However, I think that
also my solution allowing settings of samba parameters fixes most of the
problems in a way which most of the times will be easier to use. 

Usually, there is no need to modify more than a handfull of parameters so
those extra arguments to the qemu command line will be less to write than a
separate script starting samba. In my experience qemu is mostly started from a
script with a rather long qemu command line anyway.

The remaining problem is when Samba comes with a new version which requires
new settings of parameters. Regardless of solution some script will need to be
modified to solve that problem.

Again, thanks for your comment! I hope that someone will consider my patch or
your suggestion. The next thing to look into would be the possibility to start
some userspace NFS daemon as an alternative to Samba as Unix-guests works
better with NFS than CIFS. However, that would be a much bigger project and I
won't dig into such a thing until I have gotten any response on this small
patch.

regards Henrik

