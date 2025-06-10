Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D54C677C4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP29G-0006fc-Hl; Tue, 10 Jun 2025 12:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.scherle@rz.uni-freiburg.de>)
 id 1uOz5U-0007fx-CU
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:32:27 -0400
Received: from a1422.mx.srv.dfn.de ([194.95.233.70])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.scherle@rz.uni-freiburg.de>)
 id 1uOz5N-0007HA-U9
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 09:32:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 rz.uni-freiburg.de; h=content-transfer-encoding:content-type
 :content-type:in-reply-to:from:from:content-language:references
 :subject:subject:user-agent:mime-version:date:date:message-id
 :received; s=s1; t=1749562258; x=1751376659; bh=ro3c+IiFs3bUi9FY
 16JxvDzPWyC7CGD9BaZoSNhftTg=; b=L7faUY48LXdPVfFpZI196fSSFl0iZdlh
 mr5iEuFY8AcAMklgZ8XqHqAVPXRnVGKa/tFdz3AMes5yMLS/gFvazNKALV3mN/KS
 ell7yZkDBl/Z71Im/LHP4R2W2n6C+js60+1nQYQw+N/j0qm/UMVFr8QSEsBltPTj
 Sm+liLNRF1w=
Received: from fe1.uni-freiburg.de (fe1.uni-freiburg.de [132.230.2.221])
 by a1422.mx.srv.dfn.de (Postfix) with ESMTP id B0C1F1E0127
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 15:30:58 +0200 (CEST)
Received: from [10.8.8.230] (account michael.scherle@rz.uni-freiburg.de
 [10.8.8.230] verified)
 by mail.uni-freiburg.de (CommuniGate Pro SMTP 6.3.19)
 with ESMTPSA id 47896810; Tue, 10 Jun 2025 15:30:58 +0200
Message-ID: <c27a3dfa-7e3a-4fa0-a43d-5d8b5f401b0f@rz.uni-freiburg.de>
Date: Tue, 10 Jun 2025 15:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] ui/spice: Add an option for users to provide a
 preferred codec
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Frediano Ziglio <freddy77@gmail.com>,
 "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Kim, Dongwon" <dongwon.kim@intel.com>
References: <20250529051352.1409904-1-vivek.kasireddy@intel.com>
 <20250529051352.1409904-3-vivek.kasireddy@intel.com>
 <aEFYnTvaDQ6Kd0o4@redhat.com>
 <IA0PR11MB71852C724D241204B8C09AF0F86EA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <aEKVmH8ZxDcGKSeq@redhat.com>
 <CAMxuvaz1wJw-qMDDPwj_BOGPL0zdgBsi647B6+AG+OdOOomhDQ@mail.gmail.com>
 <aEgjHdDScyiuF4ID@redhat.com>
Content-Language: en-US
From: Michael Scherle <michael.scherle@rz.uni-freiburg.de>
In-Reply-To: <aEgjHdDScyiuF4ID@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.95.233.70;
 envelope-from=michael.scherle@rz.uni-freiburg.de; helo=a1422.mx.srv.dfn.de
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10.06.25 14:20, Daniel P. Berrangé wrote:
> On Tue, Jun 10, 2025 at 03:30:24PM +0400, Marc-André Lureau wrote:
>> Hi
>>
>> On Fri, Jun 6, 2025 at 11:16 AM Daniel P. Berrangé <berrange@redhat.com>
>> wrote:
>>
>> Apparently you cannot mix and match freely, it has a rather fixed set of
>> actually working values.
>>
>> See here and related code:
>> https://gitlab.freedesktop.org/spice/spice/-/blob/master/server/reds.cpp?ref_type=heads#L3468
> 
> That's just showing the built-in defaults - the parsing code is
> not enforcing any constraints. The impl though cleary only allows
> 'mjpeg' with 'spice':
> 
>    https://gitlab.freedesktop.org/spice/spice/-/blob/master/server/mjpeg-encoder.c#L1371
> 
>> Tbh, I don't think the encoder matters much, and I don't know why it was
>> decided to associate it with video codec names.
> 
> AFAICT the only way in which the encoder matters is to distinguish the
> built-in "mjpeg" impl from the gstreamer "mjpeg" coder.
> 
>> Maybe the spice API should provide a simpler form: accept only codec names.
>>
>> In the meantime, qemu should perhaps add the "working" encoder prefixes
>> (spice: for mjpeg, gstreamer: for others)  itself and not expose any extra
>> option to the user?
> 
> Ths question is whether we need to be able to request the gstreamer
> 'mjpeg' impl ?
> 
> If we do, and we also assume that 'spice' will never gain any more codec
> impls as built-ins, we could do
> 
>    builtin, mjpeg, vp8, vp9, h264

With 'spice' you mean only that the builtin will not get any more codecs 
right? because I want to do an MR for spice gstreamer to add more 
codecs, like av1.

Also It might be useful to set more parameters in future, like chroma 
sub-sampling or which GStreamer plugin is wanted like: msdk, va, vaapi....

Another point is that it can actually be a list of codecs like:
gstreamer:vp8;gstreamer:h264;spice:mjpeg

Which is maybe not clear from the current documentation, which might 
rather be:
[,video-codecs=<encoder>:<codec>[;...]]

This is useful the specify the allowed codecs and also set the priority.


> 
> where 'builtin' is the standard mjpeg encoder ?
> 
> Alternatively we could just go with
> 
>    mjpeg, vp8, vp9, h264
> 
> and in the unlikely event we need to be able to skip the built-in mjpeg,
> we could add  a boolean 'prefer-gstreamer=on|off'
> 
> With regards,
> Daniel

Greetings,
Michael


