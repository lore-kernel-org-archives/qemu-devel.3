Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38966C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxpq-0000OX-71; Wed, 02 Jul 2025 09:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWxpi-0000J5-K2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:49:07 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWxpf-0001Qo-Cs
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:49:05 -0400
Received: from example.com (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 38E79201A4A5;
 Wed,  2 Jul 2025 06:48:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 38E79201A4A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751464141;
 bh=t1Xyt6f0PSHS7ILDYAcfeKEkskrxeL97fbOoxXkxxI0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=seqEyZljiKr3NqPa+Jz8fz8oCkz02BJbg9ZXs3bOtTpXD4TG6wa7hRl/KpAKVzs72
 F12b6W4K3DoZ3Xsc875GZUT/ayYpBZgT0iNlWOy5Iz9HxoqM3PuK1WvdZOLhnbgvYc
 afOjEB01z2jDiNt8kQn+vdiZm3IG8E5AOSTfqVBc=
Date: Wed, 2 Jul 2025 15:48:53 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 05/27] include/hw/hyperv: Add MSHV ABI header
 definitions
Message-ID: <aGU4xc8uLLpTQr2o@example.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
 <20250701172834.44849-6-magnuskulke@linux.microsoft.com>
 <8734bfq7n6.fsf@redhat.com> <aGUF28/7HAMwZEpU@example.com>
 <87zfdmq3x6.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfdmq3x6.fsf@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 02, 2025 at 12:32:05PM +0200, Cornelia Huck wrote:
> On Wed, Jul 02 2025, Magnus Kulke <magnuskulke@linux.microsoft.com> wrote:
> 
> > I might not have completely understood the process though, do you
> > suggest to run `update-linux-headers.sh` on a current kernel (the other
> > headers seem to be updated from 6.16-rc*, so I assume the latest rc?)
> > and include the resulting changes in a seperate commit?
> 
> Yes, if you need to use headers imported from Linux, you should add a
> separate commit stating the release (rc) you used, and update *all* of
> the headers. As you import a new header, I would update the script to
> add the header in the same commit.
> 

thank you for the clarification. I will do that then, and split that from
the addition of the aux hyperv headers that are required.

