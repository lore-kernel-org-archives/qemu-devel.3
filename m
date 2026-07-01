Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3ABC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevP1-0007fa-Md; Wed, 01 Jul 2026 09:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.dwv5bfc3f2rv7m1=7kmadjmfmwds=f76vwpjwoiw119@em1175899.techtravels.org>)
 id 1wevOy-0007fH-Vd
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:54:57 -0400
Received: from a4i502.smtp2go.com ([158.120.81.246])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <bounce.dwv5bfc3f2rv7m1=7kmadjmfmwds=f76vwpjwoiw119@em1175899.techtravels.org>)
 id 1wevOx-00040D-Bw
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=techtravels.org;
 i=@techtravels.org; q=dns/txt; s=s1175899; t=1782914081; h=from :
 subject : to : message-id : date;
 bh=8GXe3p+WHrLoQ03NNQLOjBOxSpcpbIBpx8Xx+bYddOc=;
 b=Gvhegme/4ugLUzNquxAylPfJEG26v0O6c6GHC2IAQtp5Xh815O5CXNcjNDui6fybSfYcC
 ohOUOvkDMhd3885jeO24JbxqtkuVlKMy0vPWcFiRqmoK8arCoKjIdpig3IxozNFAz37QDih
 gzzmlC1O3yuguBNCJiRn72mLYqUq1f7Z+hqdNDc61qtq5xKuqcQ1//TwK6xbfAlJmfu+P+b
 9oBl9HKPWR/oVgI/wWDOsU0SMbtpsXpoqf/H7HVhKjzrjOm0MCfc4Cd/zcpmhFRUJOrj7Wh
 RAlfgDuI133VFSgeS1OZ/ljZoYBjnkVcieR+enurVNIVP9B0gcse61b1wb6A==
Received: from [10.91.249.253] (helo=boxtwo.techtravels.org)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <keith@techtravels.org>)
 id 1wevOg-FnQW0hPzyAo-ETk7; Wed, 01 Jul 2026 13:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=techtravels.org;
 s=mail; t=1782914076;
 bh=15r6MRTwODaC6+xeJj9PQlB5bS4FgcEYg8ouIYDlObs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=kP01do2I1d1WLG50RuyvJzB0UJ8Uw/6IpcfBwzvaQ8x4GUepKDRmCEut9ITJy0Iau
 eS8Jc7giis8LrwP10mwBRDUb7WwHRdwr0D2uTVAIgaIrKsuVB3wK0P+5OZOPvN9bdY
 sJS/pwFaeJSafmQ7S4CqM0CpReR9vUhIelEb2vmpy4wZJ61dRNGcSv2z0RPsFbc5TD
 tCELla5mtKaZdL3wWs3qZ1lncjfvvsecvUIiIeQjS7CTaodQ1pHF5ayPWfu593/0Tm
 crIMECKv4A5eDHT69shJwofE50tgMhQpmcrB2eq0rodd7NGMPXjEhP9cqyIx5or1cb
 xSlkcFusFE9CA==
Received: from authenticated-user (boxtwo.techtravels.org [54.196.37.146])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by boxtwo.techtravels.org (Postfix) with ESMTPSA id 556323F195;
 Wed,  1 Jul 2026 09:54:36 -0400 (EDT)
Message-ID: <2cf3cf84-05b4-45be-ba9a-9eb109eea4e5@techtravels.org>
Date: Wed, 1 Jul 2026 09:54:36 -0400
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] hw/scsi/ncr53c710: rewrite the 53C710 SCRIPTS engine
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260701031803.1817812-1-keith@techtravels.org>
 <20260701031803.1817812-3-keith@techtravels.org>
 <CAFEAcA-nmkUPtJgb9---_6eBFNdU5_-EndQibQOXEBn_ifUSmA@mail.gmail.com>
 <338c2683-095d-4eb6-b40d-761b79456528@techtravels.org>
 <b4388c70-d4b3-7661-36c0-e275a42c391b@eik.bme.hu>
Content-Language: en-US
From: Keith Monahan <keith@techtravels.org>
In-Reply-To: <b4388c70-d4b3-7661-36c0-e275a42c391b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 1175899m:1175899aieqF3d:1175899sPiensU06h
X-smtpcorp-track: BFKYfYcy8FZk.FvFuK-qDvw3w.KjVqIwD7qN1
Received-SPF: pass client-ip=158.120.81.246;
 envelope-from=bounce.dwv5bfc3f2rv7m1=7kmadjmfmwds=f76vwpjwoiw119@em1175899.techtravels.org;
 helo=a4i502.smtp2go.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/1/2026 8:50 AM, BALATON Zoltan wrote:

> Would it be possible to reorganise the existing lsi53c895.c to split the 
> engine you want to reuse in a separate object or module or file so it 
> can be shared without duplicating it? Then the changes to ncr53c710.c 
> should be less as it would just use the parts that were split off and 
> not copy and modify them. If that's possible it would also be better as 
> the shared parts would not be duplicated so both device models could 
> benefit from it but I understand that needs knowledge about 53c859 and 
> testing that too so it's more work but may be the preferred way to go.
Yes, definitely agree with you generally in terms of good architectural 
design. However, I think in practical terms, there's less overlap than 
you think.

There are two major issues, and two minor:

* The interrupt model differs: 710 is single-byte, 895A is stack model 
with two registers. Major.
* Reselection: Considerably different between 53C700 and 8xx family. Major.
* Endianness: big (710) vs little (895)
* Register map.

I did a quick per-function analysis this morning, just to make sure I 
didn't end up somewhere different from where I started.

* About 14% of the code is either verbatim or only had slight modification.
* With about 75% of it being either completely rewritten, or 710-only 
specific code.

So the shared design lineage is real. A fix in one can inform the other, 
but the code itself largely is not shared.

The blast radius of modifying lsi53c895a seems huge to me. I think this 
would affect a fair number of other guests well beyond what would be 
supported on LASI. The risk/reward ratio just wouldn't hold, and you are 
absolutely right about the testing asymmetry. Re-validating all of those 
guests seems like a nightmare.

There's another point here too: hppa is a smaller community of users, 
and while I'm confident that what I'm presenting is solid, I really 
don't want to expand the scope of the potential impact. With me being 
new, I don't think this is a prudent approach.

Thanks,
Keith


