Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A279EC7115C
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 05:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSr9Q-0001k6-9G; Sat, 21 Jun 2025 01:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSr9K-0001jo-9z
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 01:52:22 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uSr9H-0008Ed-Lc
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 01:52:22 -0400
Received: from [192.168.201.189]
 (210-129-16-52.radian.jp-east.compute.idcfcloud.net [210.129.16.52])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 55L5q3k7005843
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 21 Jun 2025 14:52:04 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=NzlKK4GSiPe0MWCEuCELlrDsY3UydCY9bRsdzXWqczs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1750485124; v=1;
 b=KfaSz7ByerFmSS9DQIEi42bmrUsMmYlffwqQanq261j8N99Junh43vDQ/91KGx/d
 +Xh6IXBSBr49ACJnhurwYktL11yyW1ldgVd17IiMo2MtjscypwmQ/rSayf29yS4X
 hDMC/yqtxync5CjnBDcVB48cwU4LDiin+WQOVdyI1ngImU1o4X44GuYiQvPoXryL
 4JSequaMDVuKwr4Gd+fd+lGEaRat+6Mtww9FoxoOKUjnhmPww0kytzlIJeamtyeV
 sgnzvERxnR17zzZpB3mleDEJFN0OAsgIGXLhBsryfRaqcL+ugiE3Dm4TGKJ8fUIj
 vNhaRP2ZeDO5STIQTGSgTA==
Message-ID: <22de010f-8fa3-4630-bc6c-e3ce8704ec04@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 21 Jun 2025 14:52:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vdpa: Allow VDPA to work on big-endian machine
To: Konstantin Shkolnyy <kshk@linux.ibm.com>, jasowang@redhat.com,
 yin31149@gmail.com
Cc: qemu-devel@nongnu.org, mjrosato@linux.ibm.com,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
References: <20250616133647.1662767-1-kshk@linux.ibm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250616133647.1662767-1-kshk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/06/16 22:36, Konstantin Shkolnyy wrote:
> After commit 0caed25cd171 vhost_vdpa_net_load_vlan() started seeing
> VIRTIO_NET_F_CTRL_VLAN flag and making 4096 calls to the kernel with
> VIRTIO_NET_CTRL_VLAN_ADD command. However, it forgot to convert the
> 16-bit VLAN IDs to LE format. On BE machine, the kernel calls failed
> when they saw "VLAN IDs" greater than 4095, and QEMU then said:
> "unable to start vhost net: 5: falling back on userspace virtio", and
> VDPA became disabled.
> 
> Convert the VLAN ID to LE before putting it into virtio queue.
> 
> Fixes: 8f7e9967484d ("vdpa: Restore vlan filtering state")
> Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Eugenio Pérez <eperezma@redhat.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

