Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0304DCA0EE8
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 09:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyoaq-0003KX-5g; Wed, 17 Sep 2025 05:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyoag-0003E0-Mj
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:36:43 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyoaZ-0005tI-3f
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 05:36:42 -0400
Received: from example.com (unknown [167.220.208.74])
 by linux.microsoft.com (Postfix) with ESMTPSA id D7C9B2018E64;
 Wed, 17 Sep 2025 02:36:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7C9B2018E64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758101792;
 bh=sEsOXGFGPeCM2fwA04Xk9hcqvXTmRTfKENeBYG814Ys=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YV/fUbDOhzm4cEsbgd6EOIKTLVLU/R5FiY5MNdF/qjcVUBfzpIOfJ0kalLR0XP1oy
 xDX+Hi3W2EbyEw6+LrGtDQcfDKexR69m4+haD4n01hC0s2dz9Iy9I/b8hS8ch9BG2q
 1kWZfsruWUIx9ACGxn2zOdiiVYhpstcQSyZFmOEU=
Date: Wed, 17 Sep 2025 11:36:24 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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
Subject: Re: [CRM114spam]: Re: [PATCH v4 03/27] target/i386/mshv: Add x86
 decoder/emu implementation
Message-ID: <aMqBGL4iCOr3Sszp@example.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
 <20250916164847.77883-4-magnuskulke@linux.microsoft.com>
 <aMmg_K8N1fKGUV4o@gallifrey>
 <DF061F5C-9807-4948-BD62-EC42425C5B9E@unpredictable.fr>
 <aMn29rg2b7yC7Iu7@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMn29rg2b7yC7Iu7@gallifrey>
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

On Tue, Sep 16, 2025 at 11:47:02PM +0000, Dr. David Alan Gilbert wrote:
> (I don't understand the structure as to why some stuff needs backend specific
> reads and some are in env).

Ah, that's because HVF is working on a slightly different level of
abstraction I suppose: the HVF impl will read/write values to VMCS via
VMREAD/VMWRITE, which would be Intel VMX specific.

