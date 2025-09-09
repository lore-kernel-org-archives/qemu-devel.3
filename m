Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66879CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 19:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw4K9-0004Ef-T2; Tue, 09 Sep 2025 15:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uw4K7-0004E5-C9
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:48:15 -0400
Received: from mailgate01.uberspace.is ([2001:1a50:11:0:c83f:a8ff:fea6:c8da])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1uw4K0-0008Le-UE
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 15:48:14 -0400
Received: from skiff.uberspace.de (skiff.uberspace.de [185.26.156.131])
 by mailgate01.uberspace.is (Postfix) with ESMTPS id D064E60CB2
 for <qemu-devel@nongnu.org>; Tue,  9 Sep 2025 21:48:02 +0200 (CEST)
Received: (qmail 23363 invoked by uid 990); 9 Sep 2025 19:48:02 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (plain)
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Tue, 09 Sep 2025 21:48:02 +0200
MIME-Version: 1.0
Date: Tue, 09 Sep 2025 19:48:02 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Julian Ganz" <neither@nut.email>
Message-ID: <a2eaee5105fb4b3302e2f65bb8bbea987a85454e@nut.email>
TLS-Required: No
Subject: Re: [PATCH v6 00/25] tcg-plugins: add hooks for discontinuities
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, "=?utf-8?B?QWxleCBCZW5uw6ll?="
 <alex.bennee@linaro.org>
In-Reply-To: <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
References: <cover.1757018626.git.neither@nut.email>
 <a1c2d356-e664-2632-002f-d0b9bea06e1e@eik.bme.hu>
 <cf6e7db43e9e9e59b6c9edb1c172b01ae62fb23f@nut.email>
 <df0a8c4b-ae9b-1582-1570-6cb588149a7a@eik.bme.hu>
 <3c8d0c3733edc984937ac33a417488f92dccb148@nut.email>
 <819c9f3b-13f4-2ef2-e651-5cfec52f2e12@eik.bme.hu>
X-Rspamd-Bar: /
X-Rspamd-Report: BAYES_HAM(-0.157009) MIME_GOOD(-0.1)
X-Rspamd-Score: -0.257009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from:to:cc:subject:date;
 bh=l8G0S4Dwsx9+t/5gwBOqRP+ct6TC1WJia2pS7jziG6s=;
 b=kgQBivIG0zPn3uL24caud7iA22ghmAbJGepDPs/Dm2O4y+61Gy7yjJf0aXstuMF59izcbD/Riv
 Z2QpxEki5+mUSyNrsLD9wsF3lnthonwH6sECoIg3PIMBzL8Csek9nGI8TI4/iQomJYOKVjL1WfmT
 s48aKF3UHn5ytBxtlxDsGySVgAIEv4CuQpvMk/yXyU8k5uy5/kgQ5J/jDkyoKTvQNJi2zrtn2XaF
 EpfYBpwF51dvn6Y3RMuXKK+bY07A+W665jqUtBvhWtGs9Qq4Q95Ys+1veCS3J+nDo1TzHUZNIcWq
 CsxwapeDHT9jJOuMIMW+IldyVgE601BcxiBopkeIe0x7GQEAWsyKDAwSti7lD07SLmmw2IHxmWba
 MRaKcJ+nNoyhycakPQSc2TgCNrHt+PN/nS69G1nyBYFzQlJYdKnbIWJ/i+wZy15fR2xP7k6wPJxP
 yAa0+pAw+iZbKwkRInCvBZIjbtR7SJRGQwL4OdQvOMHOXrbDUV8/YpyOppQLzvWAC20hipLulwbi
 vwfZef0B+RE1xvnG4QwuGOjSUXnJJsOl2DJojT0UVZUiYDgDCLSH+BiovPhk9VL/aitda9pwdXYU
 K3uQeCm8yqU2ppRJotWpExpi+FKZfYaA8W8klFRS19/AcvpFRS1Q43IKeVbdkecoJOKjknaMMWPH
 8=
Received-SPF: pass client-ip=2001:1a50:11:0:c83f:a8ff:fea6:c8da;
 envelope-from=neither@nut.email; helo=mailgate01.uberspace.is
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

September 7, 2025 at 10:21 PM, "BALATON Zoltan" wrote:
> I have uploaded some PPC binaries for the STREAM benchmark that I teste=
d with before here:
> http://zero.eik.bme.hu/~balaton/qemu/stream-test.zip
> which may excercise this if run on sam460ex or ppce500 machines but I d=
on't have a scripted test case for that. There is some docs on how to run=
 Linux on these machines here:
> https://www.qemu.org/docs/master/system/target-ppc.html

After spending too much time looking for usable root-images (and then
giving up and just stuffing the executables in an ext2), I got to run
these beanchmarks on Linux 4.4.5 configured for the Sam460ex from [1].

I ran streamPPCpowerpcO3 on qemu with these patches:

-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2867.6     0.056828     0.055795     0.061792
Scale:           1057.5     0.153282     0.151305     0.158115
Add:             1308.8     0.187095     0.183380     0.193672
Triad:           1111.6     0.220863     0.215902     0.230440
-------------------------------------------------------------

After doing a clean build, with the fans still audible:

-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2932.9     0.055131     0.054554     0.055667
Scale:           1067.9     0.151520     0.149832     0.155000
Add:             1324.9     0.184807     0.181150     0.191386
Triad:           1122.0     0.220080     0.213896     0.229302
-------------------------------------------------------------

On qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
patches, but plugins enabled:

-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2972.1     0.054407     0.053834     0.054675
Scale:           1068.6     0.151503     0.149726     0.154594
Add:             1327.6     0.185160     0.180784     0.193181
Triad:           1127.2     0.219249     0.212915     0.229230
-------------------------------------------------------------

And on qemu (6a9fa5ef3230a7d51e0d953a59ee9ef10af705b8) without these
patches, with plugins disabled:

-------------------------------------------------------------
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2983.4     0.055141     0.053630     0.060013
Scale:           1058.3     0.152353     0.151186     0.155072
Add:             1323.9     0.184707     0.181279     0.188868
Triad:           1128.2     0.218674     0.212734     0.230314
-------------------------------------------------------------

I fail to see any significant indication that these patches, or
plugins in general, would result in a degredation of performance.

Regards,
Julian

[1]: http://www.supertuxkart-amiga.de/amiga/sam.html#downloads

