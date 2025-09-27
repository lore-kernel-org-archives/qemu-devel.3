Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B5BCAC5BD
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 22:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2dnh-00084O-Ca; Sat, 27 Sep 2025 18:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m@maowtm.org>) id 1v2dne-00084F-3I
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 18:53:54 -0400
Received: from fout-b5-smtp.messagingengine.com ([202.12.124.148])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m@maowtm.org>) id 1v2dnW-0007s8-Dm
 for qemu-devel@nongnu.org; Sat, 27 Sep 2025 18:53:53 -0400
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 953A81D00099;
 Sat, 27 Sep 2025 18:53:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-11.internal (MEProxy); Sat, 27 Sep 2025 18:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1759013617;
 x=1759100017; bh=r8nlJBu4+DGKY/5R6PObJknBEO1eOAjKoGLmmZK/l90=; b=
 eKyDbvq/Eh8iaSy38AvYlWf4aOL1JcMHoMq5lQFzbZf/qVYYvwiJuSRXUw2wRkyi
 W84xxvDk7NHfE7DZlg+9RbWhBBAbvx9m+wRV2YfUavMdLu0A9IFeFXSLv+TF1krR
 QW7xfCZNiUiTZbltC0iQRuK1utU2zvflFuo7E1KSoGrSnZ57pKS5hP4tSDVieF4n
 i0vqcjPvxi/QhbwdZD9O5A7k7Mar+4XxER3w17Q9sHTBUdbwDMT/hwnZ/5eyITVA
 +QuHLcyNnrsiCOrW8BRrFOOPYSurbe9qzWPZvvGmQzjkIedVMiYZqhLQxtRydMow
 A3aFFVEY9aOfzVKVSCM+Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759013617; x=
 1759100017; bh=r8nlJBu4+DGKY/5R6PObJknBEO1eOAjKoGLmmZK/l90=; b=F
 j1sP+JDD2LW7MH/hNDFObuIAHmvl4ktCJ9AAQMa3ZLeuGnsUe12x/HDf49NpLFFA
 htpaRVtzbHRuNFngwO8J6C2vX2NiZqvsCL+lTmcwy9jEErKo/PAaYqnxfp07fUCl
 vivDRwyOJspJ9inMbZbV/JswgJxiTuuLyuEwgJH2sRhfvANygX3Ix8zThfN2/zV3
 eO+fOgoBl58o3v/nUh0kAmQiV2GY6T28DNqhbz8bTEXYqDtd3C/6bvC+wBFCgLFK
 yn8skA2xg5yv6/SFUn4mNvvjEdME0UAcEAfSQ0HtZdn3o40dnCtKCWAPKmGzg2v6
 UMwMVXiVRDH2+Q+ARjfpg==
X-ME-Sender: <xms:72rYaOxzkHf1iBPn_ki2J2OddRSi2ii6KjXiEPLleocB1ub2u_NlzQ>
 <xme:72rYaDqvnQf9m9t4eNo7xSt3ZYBmgM2QeaIeq8ZHkPw4jJbAHxKFKpPEp3uG09Mc4
 qLRj7lsY84FsoH8J-iKxBm4Jt--fYdvGw5eeNNrUunwDbU57zWDUsI>
X-ME-Received: <xmr:72rYaI31CI8BKu4N9Vm3gp_EKrk6hqqtvzfVMmR7yPk7mbOLlzaFOdmLGPtwjkWm5a7SjmU_LPrsd8SZM6nePVaN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejfeeglecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepvfhinhhgmhgr
 ohcuhggrnhhguceomhesmhgrohifthhmrdhorhhgqeenucggtffrrghtthgvrhhnpeduke
 evhfegvedvveeihedvvdeghfeglefgudegfeetvdekiefgledtheeggefhgfenucevlhhu
 shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmsehmrghofihtmh
 drohhrghdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhuthdprhgtphht
 thhopehmihgtseguihhgihhkohgurdhnvghtpdhrtghpthhtohepghhrohhugheskhgroh
 gurdhorhhgpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshihtvgdrtgho
 mhdprhgtphhtthhopegrshhmrgguvghushestghouggvfihrvggtkhdrohhrghdprhgtph
 htthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohes
 ihhonhhkohhvrdhnvghtpdhrtghpthhtohepvhelfhhssehlihhsthhsrdhlihhnuhigrd
 guvghvpdhrtghpthhtohepghhnohgrtghksehgohhoghhlvgdrtghomhdprhgtphhtthho
 pehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrd
 horhhg
X-ME-Proxy: <xmx:72rYaEC5odOfJqOYh5CMS46GpTM6xDb9AVvtOmNS_6861b1DtbsztQ>
 <xmx:72rYaBNm-I01NRZ7X-TivQQ5r7FXtHG9_K3YPl08Zvco5qyjf6D3Ww>
 <xmx:72rYaARSft9Pt3RFDwW19UffJldfrP84_MOYoOmm6R_M_zdt2Mdogw>
 <xmx:72rYaB4mHnSpi0BBxfmydVJphgXGQj3ht06s42pDFl2BJTwV-n3H9A>
 <xmx:8WrYaBidm_w-c5MxqEUeR0C1ovUZt-MHB6emscia4wEALnuJnqC2crNk>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 18:53:33 -0400 (EDT)
Message-ID: <dd5f424b-c6a8-4d0d-9ec0-1447fce7de39@maowtm.org>
Date: Sat, 27 Sep 2025 23:53:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] fs/9p: Reuse inode based on path (in addition to
 qid)
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <linux_oss@crudebyte.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, v9fs@lists.linux.dev, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, linux-security-module@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Matthew Bobrowski <repnop@google.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 qemu-devel@nongnu.org
References: <aMih5XYYrpP559de@codewreck.org> <3070012.VW4agfvzBM@silver>
 <f2c94b0a-2f1e-425a-bda1-f2d141acdede@maowtm.org> <3774641.iishnSSGpB@silver>
 <20250917.Eip1ahj6neij@digikod.net>
 <f1228978-dac0-4d1a-a820-5ac9562675d0@maowtm.org>
 <20250927.ahGhiiy0koo0@digikod.net>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20250927.ahGhiiy0koo0@digikod.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.148; envelope-from=m@maowtm.org;
 helo=fout-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/27/25 19:27, Mickaël Salaün wrote:
> Adding Greg Kurz too.
> 
> On Sun, Sep 21, 2025 at 05:24:49PM +0100, Tingmao Wang wrote:
>> On 9/17/25 16:00, Mickaël Salaün wrote:
>>> [...]
>>
>> Alternatively if we believe this to be a QEMU issue, maybe
>> Landlock don't need to work around it and should just hold fids (and use
>> QIDs to key the rules) anyway despite server quirks like these.  This can
>> perhaps then be fixed in QEMU?
> 
> Yes, I think it would make sense for Landlock to open and keep open a
> fid (and hopefully the related remote file).  However, the v9fs umount
> should be handled gracefully the same way Landlock tag inodes are
> handled.  This should come with a QEMU patch to fix the consistency
> issue.
> 
>>
>> (I guess the fact that QEMU is doing path tracking in the first place does
>> gives more precedent for justifying doing path tracking in v9fs as well,
>> but maybe that's the wrong way to think about it)
> 
> Anyway, if QEMU does it, wouldn't it be the same for Landlock to just
> rely on fid?

The fid can't be relied on because it's just a handle.  The client can
open multiple fids pointing to the same file (and in fact this is what
v9fs does - new fid for each open())

> If QEMU uses FD+O_PATH, then Landlock would work even for
> server-moved files.

(With this new approach, Landlock would have to key the rules based on
qid, but it also needs to hold an open fid to prevent that qid from being
reused (due to ext4 inode number reuse, etc))

