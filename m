Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78E0C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 21:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTpiW-00071m-QD; Tue, 16 Jul 2024 17:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTpiV-0006vz-2y; Tue, 16 Jul 2024 17:28:11 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sTpiS-0006yx-QX; Tue, 16 Jul 2024 17:28:10 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6A6DC7AF78;
 Wed, 17 Jul 2024 00:27:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB1DC10A8FB;
 Wed, 17 Jul 2024 00:28:01 +0300 (MSK)
Message-ID: <e1f7d0a2-9f62-4ada-bfab-6d81b5ba220d@tls.msk.ru>
Date: Wed, 17 Jul 2024 00:28:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/27] qemu-img: refersh options and --help handling,
 cleanups
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <cover.1713948448.git.mjt@tls.msk.ru>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <cover.1713948448.git.mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A friendly ping?

24.04.2024 11:50, Michael Tokarev wrote:
> Quite big patchset trying to implement normal, readable qemu-img --help
> (and qemu-img COMMAND --help) output with readable descriptions, and
> adding many long options in the process.
> 
> In the end I stopped using qemu-img-opts.hx in qemu-img.c, perhaps
> this can be avoided, with only list of commands and their desrciptions
> kept there, but I don't see big advantage here.  The same list should
> be included in docs/tools/qemu-img.rst, - this is not done now.
> 
> Also each command syntax isn't reflected in the doc for now, because
> I want to give good names for options first, - and there, we've quite
> some inconsistences and questions.  For example, measure --output=OFMT
> -O OFMT, - this is priceless :)  I've no idea why we have this ugly
> --output=json thing, why not have --json? ;)  I gave the desired
> format long name --target-format to avoid clash with --output.
> 
> For rebase, src vs tgt probably should be renamed in local variables
> too, and I'm not even sure I've got the caches right. For caches,
> the thing is inconsistent across commands.
> 
> For compare, I used --a-format/--b-format (for -f/-F), - this can
> be made --souce-format and --target-format, to compare source (file1)
> with target (file2).
> 
> For bitmap, things are scary, I'm not sure what -b SRC_FILENAME
> really means, - for now I gave it --source option, but this does
> not make it more clear, suggestions welcome.
> 
> There are many other inconsistencies, I can't fix them all in one go.
> 
> Changes since v2:
> 
>   - added Dan's R-Bs
>   - refined couple cvtnum conversions
>   - dropped "stop printing error twice in a few places"
> 
> Michael Tokarev (27):
>    qemu-img: measure: convert img_size to signed, simplify handling
>    qemu-img: create: convert img_size to signed, simplify handling
>    qemu-img: global option processing and error printing
>    qemu-img: pass current cmd info into command handlers
>    qemu-img: create: refresh options/--help
>    qemu-img: factor out parse_output_format() and use it in the code
>    qemu-img: check: refresh options/--help
>    qemu-img: simplify --repair error message
>    qemu-img: commit: refresh options/--help
>    qemu-img: compare: refresh options/--help
>    qemu-img: convert: refresh options/--help
>    qemu-img: info: refresh options/--help
>    qemu-img: map: refresh options/--help
>    qemu-img: snapshot: allow specifying -f fmt
>    qemu-img: snapshot: make -l (list) the default, simplify option
>      handling
>    qemu-img: snapshot: refresh options/--help
>    qemu-img: rebase: refresh options/--help
>    qemu-img: resize: do not always eat last argument
>    qemu-img: resize: refresh options/--help
>    qemu-img: amend: refresh options/--help
>    qemu-img: bench: refresh options/--help
>    qemu-img: bitmap: refresh options/--help
>    qemu-img: dd: refresh options/--help
>    qemu-img: measure: refresh options/--help
>    qemu-img: implement short --help, remove global help() function
>    qemu-img: inline list of supported commands, remove qemu-img-cmds.h
>      include
>    qemu-img: extend cvtnum() and use it in more places
> 
>   docs/tools/qemu-img.rst    |    4 +-
>   qemu-img-cmds.hx           |    4 +-
>   qemu-img.c                 | 1311 ++++++++++++++++++++++--------------
>   tests/qemu-iotests/049.out |    9 +-
>   4 files changed, 821 insertions(+), 507 deletions(-)
> 

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


