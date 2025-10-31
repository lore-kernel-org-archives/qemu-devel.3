Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F48CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:43:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEu3v-0008VX-Uf; Fri, 31 Oct 2025 14:41:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEu3k-0008NO-6r
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:41:14 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEu3c-0007xN-IU
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:41:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c21:2d8b:0:640:7d49:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9CAE9C0157;
 Fri, 31 Oct 2025 21:40:54 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:546::1:17] (unknown
 [2a02:6bf:8080:546::1:17])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id relVVi0F1Ko0-MtcLIM6r; Fri, 31 Oct 2025 21:40:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761936054;
 bh=ZJGAgnjDh4Wl274/GDMF4g40fWRKqyG0VF+blGd8LQE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=n5dvQ7OyHlDDGky2YsgghUCn7utX1QY9+Q7q16l/a82krPgpQGOOt37zwYijemcOE
 6wK/NrlbJyx3b7FRtnq1+0Yr/qsvJM0SHARZa0cKMSH0gdMw6QAv9N6E6lKkS19/4H
 UpmrDU1Jza7ZbTl2D59ziVxVfugE5TfnXooJI+04=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b126455a-2a1a-4278-bc8f-a77d47f4cf16@yandex-team.ru>
Date: Fri, 31 Oct 2025 21:40:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] qapi: Add documentation format validation
To: Markus Armbruster <armbru@redhat.com>
Cc: michael.roth@amd.com, qemu-devel@nongnu.org
References: <20251031115517.79032-1-vsementsov@yandex-team.ru>
 <874irf5a3a.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <874irf5a3a.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 31.10.25 19:07, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Add explicit validation for QAPI documentation formatting rules:
>>
>> 1. Lines must not exceed 70 columns in width (including '# ' prefix)
>> 2. Sentences must be separated by two spaces
>>
>> Example sections and literal :: blocks (seldom case) are excluded, we
>> don't require them to be <= 70, that would be too restrictive. Anyway,
>> they share common 80-columns recommendations (not requirements).
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> v4: apply suggestions by Markus:
>>   - smart regexps
>>   - simpler error messages
>>   - hack to move cursor at the place of error
>>   - support :: blocks
>>
>> This is based on
>> [PATCH 0/8] A QAPI schema doc markup fix, and style cleanup
>> Based-on: <20251031094751.2817932-1-armbru@redhat.com>
>>
>>   scripts/qapi/parser.py | 44 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 9fbf80a541..2c244a3608 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -108,6 +108,10 @@ def __init__(self,
>>           self.exprs: List[QAPIExpression] = []
>>           self.docs: List[QAPIDoc] = []
>>   
>> +        # State for tracking qmp-example blocks and simple
>> +        # :: literal blocks.
>> +        self._literal_mode = False
>> +
>>           # Showtime!
>>           self._parse()
>>   
>> @@ -423,12 +427,50 @@ def get_doc_line(self) -> Optional[str]:
>>               if self.val != '##':
>>                   raise QAPIParseError(
>>                       self, "junk after '##' at end of documentation comment")
>> +            self._literal_mode = False
>>               return None
>>           if self.val == '#':
>>               return ''
>>           if self.val[1] != ' ':
>>               raise QAPIParseError(self, "missing space after #")
>> -        return self.val[2:].rstrip()
>> +
>> +        line = self.val[2:].rstrip()
>> +
>> +        if re.match(r'(\.\. +qmp-example)? *::$', line):
>> +            self._literal_mode = True
> 
> This doesn't match the contracted form of literal blocks
> 
>      lorem ipsum ::
>          dolor sit amet
> 
> We don't use this form right now.  We can worry about matching it when
> we do.
> 
>> +        elif self._literal_mode and line and not line.startswith(' '):
>> +            # ReST directives stop at first non-blank non-indented line
>> +            self._literal_mode = False
> 
> This can miss the end of the literal block when the line with '::' is
> indented.  To reproduce ...
> 
>> +
>> +        if not self._literal_mode:
>> +            self._validate_doc_line_format(line)
> 
> ... tack a debug print here
> 
>             else:
>                 print('@@@', line)
> 
> and run
> 
>      $ pyvenv/bin/python3 /work/armbru/qemu/scripts/qapi-gen.py -o docs/qapi-firmware/ ../docs/interop/firmware.json
> 
> Relevant part of input:
> 
>      # @executable: Identifies the firmware executable.  The @mode
>      #     indicates whether there will be an associated NVRAM template
>      #     present.  The preferred corresponding QEMU command line options
>      #     are
>      #
>      #     ::
>      #
>      #         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
>      #         -machine pflash0=pflash0
>      #
>      #     or equivalent -blockdev instead of -drive.  When @mode is
>      #     @combined the executable must be cloned before use and
>      #     configured with readonly=off.  With QEMU versions older than
>      #     4.0, you have to use
>      #
>      #     ::
>      #
>      #         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
>      #
> 
> Relevant part of output:
> 
>      @@@     ::
>      @@@         -drive if=none,id=pflash0,readonly=on,file=@executable.@filename,format=@executable.@format
>      @@@         -machine pflash0=pflash0
>      @@@     or equivalent -blockdev instead of -drive.  When @mode is
>      @@@     @combined the executable must be cloned before use and
>      @@@     configured with readonly=off.  With QEMU versions older than
>      @@@     4.0, you have to use
>      @@@     ::
>      @@@         -drive if=pflash,unit=0,readonly=on,file=@executable.@filename,format=@executable.@format
> 
> Save the indentation of the line containing the '::'.  A line with less
> indentation ends the literal block.
> 
>> +
>> +        return line
>> +
>> +    def _validate_doc_line_format(self, line: str) -> None:
>> +        """
>> +        Validate documentation format rules for a single line:
>> +        1. Lines should not exceed 70 columns
>> +        2. Sentences should be separated by two spaces
>> +        """
>> +        full_line_length = len(line) + 2  # "# " = 2 characters
>> +        if full_line_length > 70:
>> +            # Skip URL lines - they can't be broken
>> +            if re.match(r' *(https?|ftp)://[^ ]*$', line):
>> +                pass
>> +            else:
>> +                raise QAPIParseError(
>> +                    self, "documentation line exceeds 70 columns"
>> +                )
>> +
>> +        single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
>> +        for m in list(re.finditer(single_space_pattern, line)):
>> +            if not m.group(2):
>> +                continue
>> +            # HACK so the error message points to the offending spot
>> +            self.pos = self.line_pos + 2 + m.start(2) + 1
> 
> I have an idea for a non-hacky solution.  I'll post it when ready.
> Until then, don't worry about it.
> 
>> +            raise QAPIParseError(
>> +                 self, "Use two spaces between sentences")
> 
> Note this check is somewhat prone to false positives.
> @single_space_pattern matches 'e.g.' to avoid the false positive
> 'e.g. FLAT' in block-core.json.  The same could happen for other
> abbreviations.
> 
> We could add more sophisticated heuristics to reduce the risk of false
> positives.  Meh.  I'd rather KISS for now.  We can deal with the problem
> once we have it.
> 
> We may want to add a hint, though.  Something like:
> 
>                 raise QAPIParseError(
>                      self, "Use two spaces between sentences\n"
>                      "If this not the end of a sentence, please report the bug")
> 
>>   
>>       @staticmethod
>>       def _match_at_name_colon(string: str) -> Optional[Match[str]]:
> 
> Negative tests would be nice, one for each new error.  Feel free to ask
> me to write them.
> 

No problem, it was interesting to look, how qapi-schema tests are done.

Hmm, while making the tests I thought: it would be more convenient to have all
err, json and out things in one file, like

     @json
     ##
     # @foo:
     #
     # This line has exactly 71 characters, including spaces and punctuation!
     ##
     { 'command': 'foo' }
     @out
     @err
     doc-bad-long-line.json:4:1: documentation line exceeds 70 columns

Or something like this. That will simplify creating a new test process from
copying (and modifying) three files to copying one.

(just thinking out loud, don't mind me)


v5 is sent. Tests are small and simple, I decided not split them out to separate
patches.

-- 
Best regards,
Vladimir

