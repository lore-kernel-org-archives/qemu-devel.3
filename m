Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76894C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRhr-0006Ie-G0; Sat, 29 Jun 2024 02:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNRhp-0006Hg-3O; Sat, 29 Jun 2024 02:37:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNRhm-0002GM-Qp; Sat, 29 Jun 2024 02:37:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA1D27539F;
 Sat, 29 Jun 2024 09:36:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D22DF9A4A;
 Sat, 29 Jun 2024 09:36:57 +0300 (MSK)
Message-ID: <4fa12c78-98f7-4f38-ba5d-fe7eebc4a2d8@tls.msk.ru>
Date: Sat, 29 Jun 2024 09:36:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: use strlen instead of strchr
From: Michael Tokarev <mjt@tls.msk.ru>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-trivial@nongnu.org
References: <20240628054942.657397-1-vsementsov@yandex-team.ru>
 <03e1eb96-49ce-48bb-adc7-6ea3fb843b48@tls.msk.ru>
Content-Language: en-US, ru-RU
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
In-Reply-To: <03e1eb96-49ce-48bb-adc7-6ea3fb843b48@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/29/24 09:20, Michael Tokarev wrote:
> On 6/28/24 08:49, Vladimir Sementsov-Ogievskiy wrote:
>> We already know where colon is, so no reason to search for it. Also,
>> avoid a code, which looks like we forget to check return value of
>> strchr() to NULL.
>>
>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>
>> This replaces my patch
>>    [PATCH] block/curl: explicitly assert that strchr returns non-NULL value
>> Supersedes: <20240627153059.589070-1-vsementsov@yandex-team.ru>
>>
>>   block/curl.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 419f7c89ef..d03bfe4817 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -219,7 +219,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>>           && g_ascii_strncasecmp(header, accept_ranges,
>>                                  strlen(accept_ranges)) == 0) {
>> -        char *p = strchr(header, ':') + 1;
>> +        char *p = header + strlen(accept_ranges);
>>           /* Skip whitespace between the header name and value. */
>>           while (p < end && *p && g_ascii_isspace(*p)) {
> 
> Heck.  All these strlen()s look ugly, especially in the
> loop iterations..  To my taste anyway.
> 
> How about this instead:

Or even this:

diff --git a/block/curl.c b/block/curl.c
index 419f7c89ef..982597ea7f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -210,37 +210,28 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
  {
      BDRVCURLState *s = opaque;
      size_t realsize = size * nmemb;
-    const char *header = (char *)ptr;
-    const char *end = header + realsize;
-    const char *accept_ranges = "accept-ranges:";
-    const char *bytes = "bytes";
-
-    if (realsize >= strlen(accept_ranges)
-        && g_ascii_strncasecmp(header, accept_ranges,
-                               strlen(accept_ranges)) == 0) {
-
-        char *p = strchr(header, ':') + 1;
-
-        /* Skip whitespace between the header name and value. */
-        while (p < end && *p && g_ascii_isspace(*p)) {
-            p++;
-        }
-
-        if (end - p >= strlen(bytes)
-            && strncmp(p, bytes, strlen(bytes)) == 0) {
-
-            /* Check that there is nothing but whitespace after the value. */
-            p += strlen(bytes);
-            while (p < end && *p && g_ascii_isspace(*p)) {
-                p++;
-            }
-
-            if (p == end || !*p) {
-                s->accept_range = true;
+    const char *p = (char *)ptr;
+    const char *end = p + realsize;
+    const char *t = "accept-ranges : bytes ";
+
+    while (p < end && *t) {
+        if (*t == ' ') {
+            if (g_ascii_isspace(*p)) {
+                ++p;
+            } else {
+                ++t;
              }
+        } else if (*t == g_ascii_tolower(*p)) {
+            ++p, ++t;
+        } else {
+            break;
          }
      }

+    if (p == end || !*p) {
+        s->accept_range = true;
+    }
+
      return realsize;
  }

Whole thing:

static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
{
     BDRVCURLState *s = opaque;
     size_t realsize = size * nmemb;
     const char *p = (char *)ptr;
     const char *end = p + realsize;
     const char *t = "accept-ranges : bytes ";

     while (p < end && *t) {
         if (*t == ' ') {
             if (g_ascii_isspace(*p)) {
                 ++p;
             } else {
                 ++t;
             }
         } else if (*t == g_ascii_tolower(*p)) {
             ++p, ++t;
         } else {
             break;
         }
     }

     if (p == end || !*p) {
         s->accept_range = true;
     }

     return realsize;
}

/mjt

-- 
GPG Key transition (from rsa2048 to rsa4096) since 2024-04-24.
New key: rsa4096/61AD3D98ECDF2C8E  9D8B E14E 3F2A 9DD7 9199  28F1 61AD 3D98 ECDF 2C8E
Old key: rsa2048/457CE0A0804465C5  6EE1 95D1 886E 8FFB 810D  4324 457C E0A0 8044 65C5
Transition statement: http://www.corpit.ru/mjt/gpg-transition-2024.txt


