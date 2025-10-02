Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07752CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 15:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4LM7-0002yw-Oi; Thu, 02 Oct 2025 11:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1v4LM1-0002x1-5Y
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:36:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1v4LLu-00058R-Tu
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 11:36:24 -0400
Received: from example.com (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 6071F211B7CB;
 Thu,  2 Oct 2025 08:36:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6071F211B7CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1759419376;
 bh=mFqmNQIk+D3+PDZXFhaKsQo8BF+zvO20B0AhkcoVqco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ckhfoQsszA2HTAQUAb17z/BnPe8dFmffRCmOEDYEARMaAA8Jm03ROXl6UTKQQVZnB
 1iRad28LXNaL9l9ZWRgfQEUqyxvMgswEbNQjgbQ1oY337QG6SL8NFk1dJ/Gz515Du8
 wMnCX57PXZrwmhpg79x41MxVOAtvKnCmeg7qjVFc=
Date: Thu, 2 Oct 2025 17:36:08 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?iso-8859-1?Q?=22Daniel_P=2E_Berrang=E9=22?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Eric Blake <eblake@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v4 00/27] Implementing a MSHV (Microsoft Hypervisor)
 accelerator
Message-ID: <aN6b6HcTFo/4JEa4@example.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <e176dfe8-b406-46ff-b1f0-95d4285472b7@linaro.org>
 <aN5Bjlf/xhsEHDNb@example.com>
 <3D0B6481-BA86-4CCE-8A51-63840A29F649@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D0B6481-BA86-4CCE-8A51-63840A29F649@unpredictable.fr>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
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

On Thu, Oct 02, 2025 at 04:07:39PM +0200, Mohamed Mediouni wrote:
> Worth noting that x86_64 MSHV on Linux is available to the public as part of Azure Linux,
> and runs inside of a Qemu VM just fine. (with the catch that MBEC isn’t currently emulated by KVM)
> 
> Perhaps having an Azure Linux instance in CI could be the right thing to do?
> 

Yes, that's right, MSHV is shipped as part of Azure Linux images, albeit
the mshv kernel driver in the AL kernel tree has more features that
are being upstreamed to mainline incrementally over time.

If I understand correctly, your suggestion is to run HyperV as a nested
hypervisor inside a QEMU VM (with KVM accel) on the CI machine that runs
on on baremetal/L0? (mshv-on-kvm)

We haven't tested this scenario yet, AFAIK the images that ship the
HyperV bits are meant to run as part of proprietary Azure products, so
the CI setup wouldn't really be representative of a real-world user
workloads.

We'll investigate if this is a feasible option, but I suspect that it'll
be more straight forward to provide CI runners as L1 compute on Azure
cloud (or run tests downstream somewhere if this is not trivial to
integrate).

best,

magnus

