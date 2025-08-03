Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 912AEC87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 09:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiVMv-0005Lh-Gk; Sun, 03 Aug 2025 05:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiVMn-0005Eu-IH
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 05:50:57 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uiVMl-0003xT-QE
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 05:50:57 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5739oqAu015266
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 3 Aug 2025 18:50:52 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1bKiHzSNH5cCYV1Lwn6EFtslcHo3dA6Yrtf8R+punlg=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1754214652; v=1;
 b=f/xIYQyqDQgL4obG5WCVqg2HJjQccQHNFM6vouVwjTKzXLnjMSgm0e8UtFU/z2Kl
 1M6ltobz8EkuyDVlcHWPwgzK8d2xi68tRyKKe3+WUbXrh4HCqd1wXtSXAVuVGhUG
 xRK0q3Bya8zTKGbihRxwXxaWekJJ/V99Hi+K1M5VfC4HN5WuUKvVQDFmK06rPxzj
 h17Kz+mj5E/pnHOuRCqJ8Or0Iy2Wdcj37zlrInl2EU8R7wva5qan4uDH6STNTHRy
 Dk3ICT0T0SnEBLjZeIYCiIWd2sEFZzuEc030UdTpkkajprBRkooBL1Exci2AYtqG
 JYtks/WPWTMwpY9ORrZiFQ==
Message-ID: <de6b82d7-803c-479b-9d44-162d7103c12c@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 3 Aug 2025 18:50:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250802142115.41638-2-mjt@tls.msk.ru>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250802142115.41638-2-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2025/08/02 23:21, Michael Tokarev wrote:
> The only user of this macro was VirtIONet.vlans, which has been
> converted to regular VMSTATE_BUFFER.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Nice cleanup.

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

