Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D60C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQh4-000082-CM; Tue, 04 Jun 2024 05:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEQh2-00007O-2i; Tue, 04 Jun 2024 05:43:00 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1sEQh0-0004zC-5G; Tue, 04 Jun 2024 05:42:59 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 68E9C42BC6;
 Tue,  4 Jun 2024 11:42:54 +0200 (CEST)
Message-ID: <1639f4d8-2725-4057-bb72-81be0e969c8d@proxmox.com>
Date: Tue, 4 Jun 2024 11:42:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: fix SSE and SSE2 featue check
To: Zhao Liu <zhao1.liu@intel.com>, lixinyu20s@ict.ac.cn
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, richard.henderson@linaro.org, 
 eduardo@habkost.net, Xinyu Li <lixinyu@loongson.cn>, qemu-stable@nongnu.org
References: <20240602100904.2137939-1-lixinyu20s@ict.ac.cn>
 <ZlxOA5t/1l/Cmfcs@intel.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <ZlxOA5t/1l/Cmfcs@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 02.06.24 um 12:48 schrieb Zhao Liu:
> On Sun, Jun 02, 2024 at 06:09:04PM +0800, lixinyu20s@ict.ac.cn wrote:
>> Date: Sun,  2 Jun 2024 18:09:04 +0800
>> From: lixinyu20s@ict.ac.cn
>> Subject: [PATCH] target/i386: fix SSE and SSE2 featue check
>> X-Mailer: git-send-email 2.34.1
>>
>> From: Xinyu Li <lixinyu@loongson.cn>
>>
>> Featues check of CPUID_SSE and CPUID_SSE2 shoule use cpuid_features,
>> rather than cpuid_ext_features
> 
> It's better to add a Fixes tag,
> 
> Fixes: caa01fadbef1 ("target/i386: add CPUID feature checks to new decoder")
> 

CC-ing stable, because caa01fadbef1 has been there since v7.2.0


