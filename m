Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AA0CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 10:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyTGA-0002C3-8F; Tue, 16 Sep 2025 06:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyTG7-0002BD-Qp
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:50:03 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyTG4-00047i-0V
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 06:50:02 -0400
Received: from example.com (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 15E652015502;
 Tue, 16 Sep 2025 03:49:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15E652015502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758019797;
 bh=HCbRPKcprKJcjSOATe91AM595DaV6R6vHq8N3l6VuBk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qbxLrE/yrli9F07if14u/EraMfkLE9b182+f4l5sqkYoFvocIX+n5bms3mhms0IBK
 ck06VLrwplrZuD7PjXMsPR6hCU7un9I1m60ecsfX20FVW1HDVW9x/s8qJyR+3KEcMj
 vn0NjmdH8l0jsJ6k9ZeRObYFuhv7PU6V88XKzyMA=
Date: Tue, 16 Sep 2025 12:49:49 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 18/26] target/i386/mshv: Register CPUID entries with
 MSHV
Message-ID: <aMlAzTJ7fhj3xal9@example.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
 <20250807143951.1154713-19-magnuskulke@linux.microsoft.com>
 <aK7sFds3tf5fMToM@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK7sFds3tf5fMToM@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Aug 27, 2025 at 12:29:25PM +0100, Daniel P. Berrangé wrote:
> QEMU supports a variety of CPU models. '-cpu host' is intended to
> expose every possible feature that the underlying hypervisor can
> support, while '-cpu $NAME' exposes certain named CPU models.
> 
> Also KVM will force enable certain features that it can either
> unconditionally emulate, or requires to always be present.
> 
> Are you aware if there any noteworthy differences /  restrictions
> in the use of CPU models for MSHV that would not be present for
> KVM, or vica-verca ?  I'm particularly wondering if there is
> anything special libvirt needs to be aware of - most of what
> libvirt does it gets via the QMP query-cpu-XXXX commands.
> 

The current cpuid impl is rather simple/unopionated at this point. We
will probably iterate on it in the future (e.g. include synthetic
responses). In principle it should behave similar to the KVM accel:

-cpu host is reflecting the cpuid of the host CPU (i.e. dom0/root
 partition running on Hyper‑V). We are gathering those values from
 QEMU and register them with the hypervisor.

-cpu $MODEL should works similar. The QEMU-supplied model definitions
 CPUID/MSR values are registered with HyperV. In case of an unsupported
 feature the registration would fail.

What the MSHV driver currently doesn't provide is something similar to
KVM's KVM_GET_SUPPORTED_CPUID ioctl, so we do not currently force-enable
or silently mask cpuid bits beyond what the CPU model requests.

I'm not aware of any implications for libvirt and QMP that we would need
to take into account wrt cpuid.

