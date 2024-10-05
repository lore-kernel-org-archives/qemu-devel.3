Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E941ECFB420
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 17:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx8I7-0004cx-QA; Sat, 05 Oct 2024 13:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sx8I4-0004cI-Qw
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:10:00 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1sx8I2-0005ee-IW
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 13:10:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6EE699591D;
 Sat,  5 Oct 2024 20:09:50 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A89A414E03F;
 Sat,  5 Oct 2024 20:09:53 +0300 (MSK)
Message-ID: <f0b03042-248d-4147-b96a-5809ed333fc5@tls.msk.ru>
Date: Sat, 5 Oct 2024 20:09:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Fix parse_elf_properties GNU0_MAGIC check
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241005164849.424838-1-richard.henderson@linaro.org>
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
In-Reply-To: <20241005164849.424838-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

05.10.2024 19:48, Richard Henderson wrote:
> Comparing a string of 4 bytes only works in little-endian.
> 
> Adjust bulk bswap to only apply to the note payload.
> Perform swapping of the note header manually; the magic
> is defined so that it does not need a runtime swap.

I think this is more confusing than my version, but should do the
trick too.

I wasn't sure for my patch because I missed the

  for (int i = 0; i < n / 4; i++) { bswap32s() }

loop, - now I see where it gets performs the conversion, and see why my
patch works (and why it should work too) :)

Either way,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Also noted for qemu-stable.

Thanks,

/mjt

> Fixes: 83f990eb5adb ("linux-user/elfload: Parse NT_GNU_PROPERTY_TYPE_0 notes")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2596
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 0678c9d506..52c88a68a9 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3121,11 +3121,11 @@ static bool parse_elf_properties(const ImageSource *src,
>       }
>   
>       /*
> -     * The contents of a valid PT_GNU_PROPERTY is a sequence
> -     * of uint32_t -- swap them all now.
> +     * The contents of a valid PT_GNU_PROPERTY is a sequence of uint32_t.
> +     * Swap most of them now, beyond the header and namesz.
>        */
>   #ifdef BSWAP_NEEDED
> -    for (int i = 0; i < n / 4; i++) {
> +    for (int i = 4; i < n / 4; i++) {
>           bswap32s(note.data + i);
>       }
>   #endif
> @@ -3135,15 +3135,15 @@ static bool parse_elf_properties(const ImageSource *src,
>        * immediately follows nhdr and is thus at the 4th word.  Further, all
>        * of the inputs to the kernel's round_up are multiples of 4.
>        */
> -    if (note.nhdr.n_type != NT_GNU_PROPERTY_TYPE_0 ||
> -        note.nhdr.n_namesz != NOTE_NAME_SZ ||
> +    if (tswap32(note.nhdr.n_type) != NT_GNU_PROPERTY_TYPE_0 ||
> +        tswap32(note.nhdr.n_namesz) != NOTE_NAME_SZ ||
>           note.data[3] != GNU0_MAGIC) {
>           error_setg(errp, "Invalid note in PT_GNU_PROPERTY");
>           return false;
>       }
>       off = sizeof(note.nhdr) + NOTE_NAME_SZ;
>   
> -    datasz = note.nhdr.n_descsz + off;
> +    datasz = tswap32(note.nhdr.n_descsz) + off;
>       if (datasz > n) {
>           error_setg(errp, "Invalid note size in PT_GNU_PROPERTY");
>           return false;

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


