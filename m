Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB360C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 10:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0e0a-00013X-6s; Fri, 04 Apr 2025 06:10:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torxed@archlinux.org>)
 id 1u0e0Y-00013J-Lt
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:10:42 -0400
Received: from mail.archlinux.org ([95.216.189.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torxed@archlinux.org>)
 id 1u0e0W-0006WW-5t
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 06:10:42 -0400
Content-Type: multipart/alternative;
 boundary="------------3fQdJb6aW0r8ZpcL8Oh5g0a0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
 s=dkim-rsa; t=1743761435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=w3nhvlMaBCRkqElmiodNmjyAZYWSxcqWajYo1CO4WSM=;
 b=T2D/VwM/QwQ8h5PL/8M5sKXt1p3oBdLKulKB8yu6WLRcw9/sk8W/dNXYHNdXzS2INsM67V
 Hgn6XHSmPhGvOO1+xZ5dOVwh9I8xEVGsWsX/lx0CUZ3gZcoW+f0oAOkOHFXDITRon2TtET
 crUrKcWev5eVWSakz5qI+9Kq7Y76Za7jvQ4zk5M51f9EBoj8W6LxDSQxvog3moDsFzTLkK
 XNpZ3dFDNpsXd40SIQf7kgtOT0FJAilBVkrgRoqE4Xiu1lPURP1lwYaeF0OmQVqs+8ibPu
 WAXwS+YcY7dXroydcRoG+zajrjvdLFeq9i6HH8RIpeWRDLVlax14L3guQ3Jv3BxLoc3/y9
 jsNywogFQdhf4iLBYf1RnAROnkdiKjkzA87LegA9E7IDlsaryEV+6wqneFlIcfOkw7LvVt
 ZfFg2nKB65GWKXjppbiK96YuSqSVwuojOzLVryhj1OJPLHBOidfJToYtKE89PzkkopGKBX
 J0Yhq3QFQGIsY8urR5/7AvcDjo+Ev2e8xzM1tvOCjuIEZWXXEpDxG2GAYTKDZ59fvLklQ5
 ndpvbBRQsGVohpC0fpAB/9OJ76Gq6nvYChCdXwxI/ySUXpctSxFLLtaBy/U6zqshyn9OyI
 ewY7HGBZDTT1YDPE7hUJpVqCEv7oRm+34y3Gs2tk+TeradfxR0aTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
 s=dkim-ed25519; t=1743761435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:autocrypt:autocrypt;
 bh=w3nhvlMaBCRkqElmiodNmjyAZYWSxcqWajYo1CO4WSM=;
 b=dpqhpO05T4efvmZtJur+HfOoC3gK+eQ7GylMjKz+wWwvLF+w4LyoDyg8anOrf20GqyDjt3
 pMNToHZba/mNeiBA==
Authentication-Results: mail.archlinux.org;
 auth=pass smtp.auth=torxed smtp.mailfrom=torxed@archlinux.org
Message-ID: <f14e4ca7-63ff-4dfd-85d9-8ebde2a0c840@archlinux.org>
Date: Fri, 4 Apr 2025 12:10:34 +0200
MIME-Version: 1.0
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
From: Anton Hvornum <torxed@archlinux.org>
Subject: CRITICAL Unexpected bottom half exception
Autocrypt: addr=torxed@archlinux.org; keydata=
 xjMEZDgTUBYJKwYBBAHaRw8BAQdA/aACPtPKOc90EHTO5hYUDTkxZF4iugmpsNe/kx0KTG7N
 JEFudG9uIEh2b3JudW0gPHRvcnhlZEBhcmNobGludXgub3JnPsKQBBMWCAA4FiEEiqIhPIRk
 yC2HnIEn1LWOiXqSny4FAmQ4E1ACGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQ1LWO
 iXqSny6QGgEA3rf2DSxfLdo+UcuUCIdORzycNOPlvh7+5nYAsZa54Y0BANLymRk9Jzcxsi0X
 Ua4ijul8ZMPOuFi4rRrRU+YWyHwAzsFNBGRPns4BEADPIawbmE+QdriaPoBa6egd4E7VAS6C
 1/ndymx6WBd0jYxSvHcf3NNaQ3smeayr1kWtRXF7DZMM+73NOqYSPCaH484bvKz0GvJWz5kS
 LuOKfTdYTK0UHCYqzsZgQoumLySgqBF6tTh2a9GZsIIwtslymP0NnMW2mWvLzameEYqYbeYu
 0sJnBpX4hfF7lsFkdDht5wC2iHrwE9k6Er07si3VAfb244FiS1vjkdmm34ocR6iTXBa+JO55
 yxX4T4kqPF65JCyCMucpku4jXyWPjwHdAsNbTDrAubFzEzRaWWA88W/f+cKpka82AbxhVqGa
 Er6T4Wnmc8f+rJNarnmKzLgMJ7hbgQnqSEA5vlIlAc2Rk7VboSE/6/AnKlCvHTecXiUKdZyJ
 aAUDtmkpQN/epY0fI8NKPFgcn0Ba4GavM4ylnwqDbg+Oneq9Ti2q8qYu16TTYnPb1ID0PBVg
 mSGWc0jeemLGXlDBPlJdKBeOgTbRfEEHfDobsVE9Vxsb8zuTEYJXtT/3MP/4C/eAHXUNTlRu
 OzPjCzBzcmeyC7BnVWMxKdOKgBuguZxbpfJYdbQsEQARKWhz2zssPglkwK8YS83YzQq2tHj/
 fwPUnDogEuN10nPVEpbb7UnNqp1Ww2R4H+53WWyg/jR1z5gm2PNq4RpUc5gupCaTAAkXQO+v
 lcWxUQARAQABwn4EGBYKACYWIQSKoiE8hGTILYecgSfUtY6JepKfLgUCZE+ezgIbDAUJA8Jn
 AAAKCRDUtY6JepKfLgthAQDiWLUWVEuNkKq56WGR/tvBOqNRb4urck/2bOyutnVqTQD8D/a4
 sFj5XesT7gAGKHyII5tsyev9Dg5481z+iOpGAAY=
Received-SPF: pass client-ip=95.216.189.61; envelope-from=torxed@archlinux.org;
 helo=mail.archlinux.org
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.649,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------3fQdJb6aW0r8ZpcL8Oh5g0a0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

2025-04-04 12:07:59,172 archtest CRITICAL Unexpected bottom half 
exception. This is a bug in the QMP library. Please report it to 
<qemu-devel@nongnu.org> and CC: John Snow <jsnow@redhat.com>.:
   | Traceback (most recent call last):
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 462, in _session_guard
   |     yield
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 417, in connect
   |     await self._establish_session()
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py", 
line 297, in _establish_session
   |     self._greeting = await self._get_greeting()
   |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py", 
line 317, in _get_greeting
   |     msg = await self._recv()
   |           ^^^^^^^^^^^^^^^^^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 1046, in _recv
   |     message = await self._do_recv()
   |               ^^^^^^^^^^^^^^^^^^^^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py", 
line 449, in _do_recv
   |     msg_bytes = await self._readline()
   |                 ^^^^^^^^^^^^^^^^^^^^^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 1014, in _readline
   |     raise EOFError
   | EOFError
   |
   | During handling of the above exception, another exception occurred:
   |
   | Traceback (most recent call last):
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 468, in _session_guard
   |     await self.disconnect()
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 436, in disconnect
   |     await self._wait_disconnect()
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 758, in _wait_disconnect
   |     self._cleanup()
   |     ~~~~~~~~~~~~~^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py", 
line 385, in _cleanup
   |     super()._cleanup()
   |     ~~~~~~~~~~~~~~~~^^
   |   File 
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py", 
line 772, in _cleanup
   |     assert self.runstate == Runstate.DISCONNECTING
   |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   | AssertionError


--------------3fQdJb6aW0r8ZpcL8Oh5g0a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <font face="Hack">2025-04-04 12:07:59,172 archtest CRITICAL
      Unexpected bottom half exception. This is a bug in the QMP
      library. Please report it to <a class="moz-txt-link-rfc2396E" href="mailto:qemu-devel@nongnu.org">&lt;qemu-devel@nongnu.org&gt;</a> and CC:
      John Snow <a class="moz-txt-link-rfc2396E" href="mailto:jsnow@redhat.com">&lt;jsnow@redhat.com&gt;</a>.:<br>
        | Traceback (most recent call last):<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 462, in _session_guard<br>
        |     yield<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 417, in connect<br>
        |     await self._establish_session()<br>
        |   File
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
      line 297, in _establish_session<br>
        |     self._greeting = await self._get_greeting()<br>
        |                      ^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
        |   File
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
      line 317, in _get_greeting<br>
        |     msg = await self._recv()<br>
        |           ^^^^^^^^^^^^^^^^^^<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 1046, in _recv<br>
        |     message = await self._do_recv()<br>
        |               ^^^^^^^^^^^^^^^^^^^^^<br>
        |   File
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
      line 449, in _do_recv<br>
        |     msg_bytes = await self._readline()<br>
        |                 ^^^^^^^^^^^^^^^^^^^^^^<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 1014, in _readline<br>
        |     raise EOFError<br>
        | EOFError<br>
        | <br>
        | During handling of the above exception, another exception
      occurred:<br>
        | <br>
        | Traceback (most recent call last):<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 468, in _session_guard<br>
        |     await self.disconnect()<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 436, in disconnect<br>
        |     await self._wait_disconnect()<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 758, in _wait_disconnect<br>
        |     self._cleanup()<br>
        |     ~~~~~~~~~~~~~^^<br>
        |   File
"/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/qmp_client.py",
      line 385, in _cleanup<br>
        |     super()._cleanup()<br>
        |     ~~~~~~~~~~~~~~~~^^<br>
        |   File
      "/home/anton/.local/lib/python3.13/site-packages/qemu/qmp/protocol.py",
      line 772, in _cleanup<br>
        |     assert self.runstate == Runstate.DISCONNECTING<br>
        |            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^<br>
        | AssertionError<br>
      <br>
      <br>
    </font>
  </body>
</html>

--------------3fQdJb6aW0r8ZpcL8Oh5g0a0--

