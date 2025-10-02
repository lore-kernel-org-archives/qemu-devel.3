Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDEC7CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FLC-0005Vy-6t; Thu, 02 Oct 2025 05:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1v4FL3-0005VK-BX
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:11:03 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1v4FKv-00021R-Dz
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:10:58 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 89DCD211B7BA;
 Thu,  2 Oct 2025 02:10:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 89DCD211B7BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1759396246;
 bh=zHkUxTBb/0s+vTp13ZX4vwft/bEdRAjVZb/F53APAkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qAVBSFmJZlwEdJf6qepy4gkx+uAecZ7EnBkAXMkGPYSChtgbhs762qcaymcfWl0yS
 ydNNzf+W4AuVoYwzaECU6e8tug+TjAZjigwLV667us25Ms/QzGXCd0HcFkLujuqezD
 prjzDypexdaOAYfscaMrhRDVHr3AObDYmQIXyMx0=
Date: Thu, 2 Oct 2025 11:10:38 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aN5Bjlf/xhsEHDNb@example.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 02, 2025 at 10:30:56AM +0200, Philippe Mathieu-Daudé wrote:
> Due to my generic work on accelerators, I'll have to refactor these
> patches. Obviously I don't want to break your implementation! Can
> you add some (functional?) tests? Ideally we should be running
> tests on our CI to ensure code doesn't bitrot.
> 
> Regards,
> 
> Phil.

Hey Phil,

yes, that's a good point. I assume for functional tests we
will face the challenge those will require external infra, because
eventually there needs to be a HyperV Hypervisor running somewhere.

Is there any precedent/prior art in QEMU (e.g. for HVF or WHPX) that we
could follow?

FWIW, in smoke tests for the patch series I've been using a nested
HyperV hypervisor that is shipped as dll and made available as UEFI
protocol to the MSHV driver (I _think_ that is how it works, I'm a
bit out of my depth here since I don't know how those things are
glued together in detail).

For reference: https://github.com/mkulke/qemu/actions/runs/18187719634

There will be other virt topologies supported by the MSHV driver and
the nested option is not upstreamed to mainline yet. However, from
QEMU's perspective those topologies do not matter, they share the same
ABI of the kernel driver.

So we could do something similar, provide/maintain a VM on Azure with a
similar nested HyperV hypervisor configuration that we can used for
testing. Would this make sense?

Best,

magnus

