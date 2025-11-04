Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E92CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 10:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGEhl-00053w-Sp; Tue, 04 Nov 2025 05:56:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGEhi-00053b-N6
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:55:59 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vGEhg-0006Om-1y
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 05:55:58 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id DA90AC00D8;
 Tue, 04 Nov 2025 13:55:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:95c::1:2] (unknown [2a02:6bf:8080:95c::1:2])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pthVtd1GpmI0-Dh5D7m8w; Tue, 04 Nov 2025 13:55:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1762253751;
 bh=oK3coXkP4VC1NFgpPQ6doZteV5F8BnYvZ3YOZXffHyA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Ftj9R2d55rUYieU0BNoRgN+YhEneayI0Kee6G3ABpDIewq2nc9YKCu7plheueNAKS
 o+7juayEJEO8FrpL++aa9Rp0ZpiacKmtPbH2solajxuVSLpqSYJgGAr3+XmW3pVAjy
 lReZySPRNs2FjT5U24HVudMpGr74dHheXT2sU2dc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <f1e50de9-912d-430e-ac0d-8341e003be13@yandex-team.ru>
Date: Tue, 4 Nov 2025 13:55:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] qapi: Add documentation format validation
To: Markus Armbruster <armbru@redhat.com>
Cc: michael.roth@amd.com, qemu-devel@nongnu.org
References: <20251031183129.246814-1-vsementsov@yandex-team.ru>
 <87pl9yun57.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87pl9yun57.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04.11.25 13:07, Markus Armbruster wrote:
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
>> Add two simple tests, illustrating the change.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> Hi all!
>>
>> v5: - break "literal" block at any decreasing the indent,
>>        not only at no-indent
>>      - add two simple tests
>>
>> This is based on
>> [PATCH 0/8] A QAPI schema doc markup fix, and style cleanup
>> Based-on: <20251031094751.2817932-1-armbru@redhat.com>
>>
>>   scripts/qapi/parser.py                     | 52 +++++++++++++++++++++-
>>   tests/qapi-schema/doc-bad-long-line.err    |  1 +
>>   tests/qapi-schema/doc-bad-long-line.json   |  6 +++
>>   tests/qapi-schema/doc-bad-long-line.out    |  0
>>   tests/qapi-schema/doc-bad-whitespaces.err  |  2 +
>>   tests/qapi-schema/doc-bad-whitespaces.json |  6 +++
>>   tests/qapi-schema/doc-bad-whitespaces.out  |  0
>>   tests/qapi-schema/meson.build              |  2 +
>>   8 files changed, 68 insertions(+), 1 deletion(-)
>>   create mode 100644 tests/qapi-schema/doc-bad-long-line.err
>>   create mode 100644 tests/qapi-schema/doc-bad-long-line.json
>>   create mode 100644 tests/qapi-schema/doc-bad-long-line.out
>>   create mode 100644 tests/qapi-schema/doc-bad-whitespaces.err
>>   create mode 100644 tests/qapi-schema/doc-bad-whitespaces.json
>>   create mode 100644 tests/qapi-schema/doc-bad-whitespaces.out
>>
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 9fbf80a541..ffb149850d 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -108,6 +108,11 @@ def __init__(self,
>>           self.exprs: List[QAPIExpression] = []
>>           self.docs: List[QAPIDoc] = []
>>   
>> +        # State for tracking qmp-example blocks and simple
>> +        # :: literal blocks.
>> +        self._literal_mode = False
>> +        self._literal_mode_indent = 0
>> +
>>           # Showtime!
>>           self._parse()
>>   
>> @@ -423,12 +428,57 @@ def get_doc_line(self) -> Optional[str]:
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
> 
> After a closer reading of ReST docs and some testing: this isn't quite
> right, although it works okay for what we have.
> 
> A directive's '::' need not be at the end of a line.  The regexp fails
> to match a qmp-example directive with text after '::'.  No such
> directives exist right now.
> 
> A literal block starts after a '::' at the end of a paragraph,
> i.e. after '::' and a blank line.  The regexp only matches '::' on its
> own line, not at the end of a line of text.  It matches it even when
> it's not followed by a blank line.
> 
> In review of v4, I claimed we don't use the contracted form "text::".
> Not true.  For instance, in block-core.json:
> 
>     # @bins: list of io request counts corresponding to histogram
>     #     intervals, one more element than @boundaries has.  For the
>     #     example above, @bins may be something like [3, 1, 5, 2], and
>     #     corresponding histogram looks like::
>     #
>     #        5|           *
>     #        4|           *
>     #        3| *         *
>     #        2| *         *    *
>     #        1| *    *    *    *
>     #         +------------------
>     #             10   50   100
>     #

Ow, my old histograms)

>     # Since: 4.0
>     ##
> 
> The literal block starts after "like::" and ends before "Since:'.
> 
>> +            self._literal_mode = True
>> +            self._literal_mode_indent = 0
>> +        elif self._literal_mode and line:
>> +            indent = re.match(r'^ *', line).end()
>> +            if self._literal_mode_indent == 0:
>> +                self._literal_mode_indent = indent
>> +            elif indent < self._literal_mode_indent:
>> +                # ReST directives stop at decreasing indentation
>> +                self._literal_mode = False
> 
> This isn't quite right, either.  We need to stop when indentation of
> non-blank lines drops below the indentation of the line containing the
> '::'.
> 
> Perhaps it's easier for both of us if I fix this on top.  Thoughts?

No objections, good for me!

> 
>> +
>> +        if not self._literal_mode:
>> +            self._validate_doc_line_format(line)
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
>> +            raise QAPIParseError(
>> +                self, "Use two spaces between sentences\n"
>> +                "If this not the end of a sentence, please report the bug",
>> +            )
>>   
>>       @staticmethod
>>       def _match_at_name_colon(string: str) -> Optional[Match[str]]:
>> diff --git a/tests/qapi-schema/doc-bad-long-line.err b/tests/qapi-schema/doc-bad-long-line.err
>> new file mode 100644
>> index 0000000000..611a3b1fef
>> --- /dev/null
>> +++ b/tests/qapi-schema/doc-bad-long-line.err
>> @@ -0,0 +1 @@
>> +doc-bad-long-line.json:4:1: documentation line exceeds 70 columns
>> diff --git a/tests/qapi-schema/doc-bad-long-line.json b/tests/qapi-schema/doc-bad-long-line.json
>> new file mode 100644
>> index 0000000000..d7f887694d
>> --- /dev/null
>> +++ b/tests/qapi-schema/doc-bad-long-line.json
>> @@ -0,0 +1,6 @@
>> +##
>> +# @foo:
>> +#
>> +# This line has exactly 71 characters, including spaces and punctuation!
> 
> Really?

Oh, it's 72 characters actually! AI tricked me. Didn't I check it out?

Maybe:

# This line has exactly 71 chars, including the leading hash and space.



> 
>> +##
>> +{ 'command': 'foo' }
>> diff --git a/tests/qapi-schema/doc-bad-long-line.out b/tests/qapi-schema/doc-bad-long-line.out
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/qapi-schema/doc-bad-whitespaces.err b/tests/qapi-schema/doc-bad-whitespaces.err
>> new file mode 100644
>> index 0000000000..5cca1954c0
>> --- /dev/null
>> +++ b/tests/qapi-schema/doc-bad-whitespaces.err
>> @@ -0,0 +1,2 @@
>> +doc-bad-whitespaces.json:4:48: Use two spaces between sentences
>> +If this not the end of a sentence, please report the bug
>> diff --git a/tests/qapi-schema/doc-bad-whitespaces.json b/tests/qapi-schema/doc-bad-whitespaces.json
>> new file mode 100644
>> index 0000000000..b0c318c670
>> --- /dev/null
>> +++ b/tests/qapi-schema/doc-bad-whitespaces.json
>> @@ -0,0 +1,6 @@
>> +##
>> +# @foo:
>> +#
>> +# Sentences should be split by two whitespaces. But here is only one.
> 
> two spaces
> 
>> +##
>> +{ 'command': 'foo' }
>> diff --git a/tests/qapi-schema/doc-bad-whitespaces.out b/tests/qapi-schema/doc-bad-whitespaces.out
>> new file mode 100644
>> index 0000000000..e69de29bb2
>> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
>> index c47025d16d..b24b27db21 100644
>> --- a/tests/qapi-schema/meson.build
>> +++ b/tests/qapi-schema/meson.build
>> @@ -61,8 +61,10 @@ schemas = [
>>     'doc-bad-event-arg.json',
>>     'doc-bad-feature.json',
>>     'doc-bad-indent.json',
>> +  'doc-bad-long-line.json',
>>     'doc-bad-symbol.json',
>>     'doc-bad-union-member.json',
>> +  'doc-bad-whitespaces.json',
>>     'doc-before-include.json',
>>     'doc-before-pragma.json',
>>     'doc-duplicate-features.json',
> 


-- 
Best regards,
Vladimir

