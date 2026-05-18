Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA74CD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 15:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOzTW-00074a-4L; Mon, 18 May 2026 11:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wOzTU-00074R-Ow
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:01:44 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wOzTT-00036N-Br
 for qemu-devel@nongnu.org; Mon, 18 May 2026 11:01:44 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 0BB4D240106
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 17:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1779116497; bh=di3D8N3hni1e73/cH/q7OoqVEWwyZrfyuC4NAjAbA3Q=;
 h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
 Content-Transfer-Encoding:From;
 b=rZCQafOdSssO/SZLqkcWlykn5fY33JBlIky/O9fZFI5AmiJazcdsGiImATG9ca9oj
 KlpyBnMbPHzbH+7A7leFV4IuPBhrr1NwgBHikXSsuHBRqq+9QSqkk6fzAGPVbDrmNP
 v+Kn9FY/kxfpFwG+svZMuI5gGMqsPHhpe+tMdpDAxJm+Bx8usdLQbwJ0ZQ18qPX+Yb
 eL7vb0WCi6lA6HG051Qf9ybCucS0s3GdOM4YdbLVm35/Qa97gtSEevKmOznsmttCPF
 Y6z5hf4zUZwsX8G+5tywemkhNq+c5z3npTcHnUXv1hLGJcVDd4mfbbRLQEXMvJVL9L
 SwIojv/O2XQTQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gK1Gl0MCbz6tvm;
 Mon, 18 May 2026 17:01:35 +0200 (CEST)
MIME-Version: 1.0
Date: Mon, 18 May 2026 15:01:36 +0000
From: mateusz.nowicki@posteo.net
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, "Dr. David Alan Gilbert"
 <dave@treblig.org>, Keith Busch <kbusch@kernel.org>, Jesper Devantier
 <foss@defmacro.it>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 1/2] hw/nvme: add 'info nvme' HMP command
In-Reply-To: <agsLdWIugBvTxz8W@AALNPWKJENSEN.aal.scsc.local>
References: <cover.1778409416.git.mateusz.nowicki@posteo.net>
 <f419a9cf97e79b5148c10cd0a3c138dccb5d36a0.1778409416.git.mateusz.nowicki@posteo.net>
 <agsLdWIugBvTxz8W@AALNPWKJENSEN.aal.scsc.local>
Message-ID: <04b7f47281f7e4bd6900e36c1f703356@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.66;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> I think this needs to run over n->conf_ioqpairs to also work for SR-IOV
> VFs? Same goes for patch 2 I think.
> 

Good catch, agreed.  Sending v3 with the fix applied to both patches.
Thanks,
Mateusz

