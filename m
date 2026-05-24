Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66BF0CD5BAB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2026 19:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wREff-0005Pi-3T; Sun, 24 May 2026 15:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREfL-0005Mv-Ui; Sun, 24 May 2026 15:39:18 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chad@jablonski.xyz>)
 id 1wREfK-0001RT-94; Sun, 24 May 2026 15:39:15 -0400
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 43733140010B;
 Sun, 24 May 2026 15:39:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Sun, 24 May 2026 15:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jablonski.xyz;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1779651552; x=1779737952; bh=/0sWTEBG6nQWT6uGBxCpm5MOAbG6g+Tf
 ZrfxqMa2b7o=; b=UgkSa6BHrj0suowgAAjtQVUfKsSNgcf5K/3teYQLpAsKr65k
 DZEIsfiAlEBgYQFdaqJUMRiy++pwU7l1qn5S9p4ru53jx3fd4G5PDsNz5hl8iFN7
 soVz2k+tu3Qlq0ueuqHbF7799mw8ds3kqpuVwZb/9rw9OGkLmgxiC5Zkqg1cCkNL
 2K0tlUTRrAZGu2pIQ51kjDw+hIFssHWSuAeGVwHnzRfq9bTmTl9MOn2iqQuMorp7
 zl7tUN8Gh+1eisRJB0aKet5bhG0b3wZCsK3kx1XZhqzTfpbJv+MUj5ZOsPbfdggT
 ffVqPVquI6jh77uUMdV5igYxjEVYLaBmbx+VFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779651552; x=
 1779737952; bh=/0sWTEBG6nQWT6uGBxCpm5MOAbG6g+TfZrfxqMa2b7o=; b=V
 zHiUk5zr2//m3OjfN6te2MskJOy0NGi5dRga0JjSAoJfqKCJW8TvC9ODFGVMZMAx
 gcMHJ5LE9msBbrjB6JAFaDwvrGOTi1hnUF3zOfiUzF3Y1awTZfUD5Ou5z/wJ6Ep4
 txWY1lW6JdKxPtKh1ojNX7BEOv6kPQ3fgjDMax9+51XTCrE1/cQsKaNYLR9qnyY6
 rk9oMuyxKx/ple5vfrbE4NDGNqRStBvzg1izN1TGE4ZIsi/2sxLmLNwfjz3h/xp9
 4H1d/eaOT2CL11kxa02ku4HjqV7oPhqsILsW6rnGB6IAejIm/q8/mnyuVFhOoEKW
 q4uGWDgl2Ao2gE2IlavIg==
X-ME-Sender: <xms:4FMTavJBAD0GZGUc6Fe5yAGdJ3YMEqKM-Th--fI28OYfYJfRoI02EQ>
 <xme:4FMTaqJAoj6gvYNX-3raovL-OXRLiUgNd29gEV2GSztQkOwZwS8vPmHt0anJZ_DW6
 w703OjmuhSvWowi4-2QS3_4_QAhlZckRoJfWt7lBduPdhrBMVzoVvng>
X-ME-Received: <xmr:4FMTasseafDdlZDqUG1vL2NMf7yVe5gkPGIoph5OPW2QyDDiI1BtmzZMFzpd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduheeijeelucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
 hlucfvnfffucdlfeehmdenucfjughrpegtfffkvefuhffvggfgofhfjgesthhqredtredt
 jeenucfhrhhomhepfdevhhgrugculfgrsghlohhnshhkihdfuceotghhrggusehjrggslh
 honhhskhhirdighiiiqeenucggtffrrghtthgvrhhnpeetleeiiefgffejudelhedthffh
 udehieetkeeufeekvedvieettdekteeludfhgfenucffohhmrghinheptghouggvsggvrh
 hgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
 mheptghhrggusehjrggslhhonhhskhhirdighiiipdhnsggprhgtphhtthhopeegpdhmoh
 guvgepshhmthhpohhuthdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhu
 rdhorhhgpdhrtghpthhtoheptghhrggusehjrggslhhonhhskhhirdighiiipdhrtghpth
 htohepqhgvmhhuqdguvghvvghlqdgsohhunhgtvghsodgthhgrugepjhgrsghlohhnshhk
 ihdrgiihiiesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepsggrlhgrthhonhesvghikh
 drsghmvgdrhhhu
X-ME-Proxy: <xmx:4FMTanSMsBTe2RzPoUtvWQ5xadc_PHy3jhppOJynN5SLjY4_3YtD8A>
 <xmx:4FMTaiM7jS1eDlsRqi1VsZByxxYEHGqaOivjyx2_fV8ZA-G70FjuzA>
 <xmx:4FMTasbtHXWZTIK0RM-HDdw9vDEFjlcw3yCBYHdLNO8UpK9HqBPJtg>
 <xmx:4FMTasw00S_ccez036ktxrdS3ZjPoC68vrMtr5-o_tze-_fdKm0VkQ>
 <xmx:4FMTavTfN_fIt0geL7Le58vOIhiqhpydAGezfMYr-5Fz87tP9edHBDMJ>
Feedback-ID: ib26944c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 May 2026 15:39:11 -0400 (EDT)
Received: from localhost (chomposaur [local])
 by chomposaur (OpenSMTPD) with ESMTPA id c89e9686;
 Sun, 24 May 2026 19:39:11 +0000 (UTC)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 24 May 2026 15:39:11 -0400
Message-Id: <DIR5TO4BY98U.2E7PHJ6MND0QE@jablonski.xyz>
Cc: <qemu-devel@nongnu.org>, <qemu-devel-bounces+chad=jablonski.xyz@nongnu.org>
Subject: Re: [PATCH v2 2/7] ati-vga: Implement CCE/PM4 microcode register
 handling
From: "Chad Jablonski" <chad@jablonski.xyz>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, "Chad Jablonski"
 <chad@jablonski.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20260101035555.1300511-1-chad@jablonski.xyz>
 <20260101035555.1300511-3-chad@jablonski.xyz>
 <20a6233c-7214-01de-196d-117bf55d9563@eik.bme.hu>
In-Reply-To: <20a6233c-7214-01de-196d-117bf55d9563@eik.bme.hu>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=chad@jablonski.xyz;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_SUSPICIOUS_NTLD=0.5, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_PDS_OTHER_BAD_TLD=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

>> diff --git a/hw/display/ati.c b/hw/display/ati.c
>> index 33f8e211dc..e291926470 100644
>> --- a/hw/display/ati.c
>> +++ b/hw/display/ati.c
>> @@ -510,6 +510,31 @@ static uint64_t ati_mm_read(void *opaque, hwaddr ad=
dr, unsigned int size)
>>     case DEFAULT_SC_BOTTOM_RIGHT:
>>         val =3D s->regs.default_sc_bottom_right;
>>         break;
>> +    case PM4_MICROCODE_ADDR:
>> +        val =3D s->cce.microcode.addr;
>> +        break;
>> +    case PM4_MICROCODE_RADDR:
>> +        val =3D 0;
>
> Should this return s->cce.microcode.raddr? (More comments below.)
>

Hardware testing shows that this register always returns 0 when read.
https://codeberg.org/cjab/ati-tests/src/commit/55ddfe401f1fe5702a5f333b72b2=
2e70a815fa02/tests/common/cce.c#L158-L165

>> diff --git a/hw/display/ati_cce.h b/hw/display/ati_cce.h
>> new file mode 100644
>> index 0000000000..f2ef1345de
>> --- /dev/null
>> +++ b/hw/display/ati_cce.h
>
> I'm not sure this needs a separate header, we could just put everything i=
n=20
> ati_int.h which is meant to be a common header for internal=20
> imlementation stuff but if you prefer it separate that's fine too.
>

Ah, that makes sense! Agreed, I'll move it to ati_int.h for now. If
things get complicated we can always break it out later.


