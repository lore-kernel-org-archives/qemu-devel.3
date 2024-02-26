Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE7C0C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 15:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1recSJ-0008Kb-DX; Mon, 26 Feb 2024 09:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1recSG-0008Jz-NM; Mon, 26 Feb 2024 09:59:44 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1recSE-0002ZK-4A; Mon, 26 Feb 2024 09:59:44 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C7A0550AC1;
 Mon, 26 Feb 2024 18:00:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DA80189A3E;
 Mon, 26 Feb 2024 17:59:38 +0300 (MSK)
Message-ID: <6c03f092-b308-49ca-a1c5-6febc394c42a@tls.msk.ru>
Date: Mon, 26 Feb 2024 17:59:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/28] qemu-img: resize: do not always eat last argument
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <cover.1708544927.git.mjt@tls.msk.ru>
 <20240221211622.2335170-19-mjt@tls.msk.ru> <Zdylwbu94EKzB73y@redhat.com>
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
In-Reply-To: <Zdylwbu94EKzB73y@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

26.02.2024 17:52, Daniel P. Berrangé wrote:
> On Thu, Feb 22, 2024 at 12:16:00AM +0300, Michael Tokarev wrote:
>> 'qemu-img resize --help' does not work, since it wants more
>> arguments.  Also it -size is only recognized as a very last
>> argument, but it is common for tools to handle other options
>> after positional arguments too.
>>
>> Tell getopt_long() to return non-options together with options,
>> and process filename and size in the loop, and check if there's
>> an argument right after filename which looks like -N (number),
>> and treat it as size (decrement).  This way we can handle --help,
>> and we can also have options after filename and size, and `--'
>> will be handled fine too.
>>
>> The only case which is not handled right is when there's an option
>> between filename and size, and size is given as decrement, - in
>> this case -size will be treated as option, not as size.
>>
>> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
>> ---
>>   qemu-img.c | 41 +++++++++++++++++++++++++++--------------
>>   1 file changed, 27 insertions(+), 14 deletions(-)
>>
>> diff --git a/qemu-img.c b/qemu-img.c
>> index 2a4bff2872..c8b0b68d67 100644
>> --- a/qemu-img.c
>> +++ b/qemu-img.c
>> @@ -4296,7 +4296,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>>   {
>>       Error *err = NULL;
>>       int c, ret, relative;
>> -    const char *filename, *fmt, *size;
>> +    const char *filename = NULL, *fmt = NULL, *size = NULL;
>>       int64_t n, total_size, current_size;
>>       bool quiet = false;
>>       BlockBackend *blk = NULL;
>> @@ -4319,17 +4319,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>>       bool image_opts = false;
>>       bool shrink = false;
>>   
>> -    /* Remove size from argv manually so that negative numbers are not treated
>> -     * as options by getopt. */
>> -    if (argc < 3) {
>> -        error_exit(argv[0], "Not enough arguments");
>> -        return 1;
>> -    }
>> -
>> -    size = argv[--argc];
>> -
>>       /* Parse getopt arguments */
>> -    fmt = NULL;
>>       for(;;) {
>>           static const struct option long_options[] = {
>>               {"help", no_argument, 0, 'h'},
>> @@ -4339,7 +4329,7 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>>               {"shrink", no_argument, 0, OPTION_SHRINK},
>>               {0, 0, 0, 0}
>>           };
>> -        c = getopt_long(argc, argv, ":f:hq",
>> +        c = getopt_long(argc, argv, "-:f:hq",
> 
> In other patches you removed the initial ':' from gopt_long arg strings.

Yes, this is done in the next patch, "resize: refresh options/help".

>>                           long_options, NULL);
>>           if (c == -1) {
>>               break;
>> @@ -4377,12 +4367,35 @@ static int img_resize(const img_cmd_t *ccmd, int argc, char **argv)
>>           case OPTION_SHRINK:
>>               shrink = true;
>>               break;
>> +        case 1: /* a non-optional argument */
>> +            if (!filename) {
>> +                filename = optarg;
>> +                /* see if we have -size (number) next to filename */
>> +                if (optind < argc) {
>> +                    size = argv[optind];
>> +                    if (size[0] == '-' && size[1] >= '0' && size[1] <= '9') {
>> +                        ++optind;
>> +                    } else {
>> +                        size = NULL;
>> +                    }
>> +                }
>> +            } else if (!size) {
>> +                size = optarg;
>> +            } else {
>> +                error_exit(argv[0], "Extra argument(s) in command line");
>> +            }
>> +            break;
> 
> Can you say what scenario exercises this code 'case 1' ?  I couldn't
> get it to run in any scenarios i tried, and ineed removing this,
> and removing the 'getopt_long' change, I could still run  'qemu-img resize --help'
> OK, and also run 'qemu-img resize foo -43' too.


I was thinking about
   qemu-img resize foo -43 -f qcow2 ..

if not only to make it all consistent with everything else
(options has always been recognized after non-optional args
in gnu/linux world, all utils does that).

But in all scenarios, after changing first char of optstring to include
'-', this code will be called for any non-optional argument.  In this
case, it will be done for argument `foo', and there. -43 will  be
recognized by this piece of code as a size modification since it
starts with minus and follows with a number.

The handling of positional args after the getopt loop is also needed
to handle situations like

   qemu-img resize -- foo 43

-- everything after `--' will be left to that code.

/mjt


