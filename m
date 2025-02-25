Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09959C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 07:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpFZ-0001nc-Jb; Tue, 25 Feb 2025 02:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmpFW-0001ms-M3
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:21:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tmpFV-0006cC-2x
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 02:21:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740468057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
 bh=Uw9g3ebhh6y/oIKBymd0XvzraJEhpz7ObDeq9JDAYk4=;
 b=bg6wWNtVmfAmQHF2h+UPJyCuJv2Kk5JTIG6CylgJ2+RpgU2sraqxENuhplkRKGWn43pMWb
 bcJOVtqQOxGfqnOS6RnhuNgTvsYX8e4BxR7v/U08PVIT0gnMgDaN78kcJfDhB33h4OnCyb
 MrR5Gg1xY4iLImK83025kecW/JZ0dOQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-5wcokU3sOCSFgMkkK1Cedw-1; Tue, 25 Feb 2025 02:20:54 -0500
X-MC-Unique: 5wcokU3sOCSFgMkkK1Cedw-1
X-Mimecast-MFC-AGG-ID: 5wcokU3sOCSFgMkkK1Cedw_1740468053
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38f2c0aa6d6so2742407f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 23:20:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740468053; x=1741072853;
 h=content-transfer-encoding:autocrypt:subject:cc:to:content-language
 :from:user-agent:mime-version:date:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uw9g3ebhh6y/oIKBymd0XvzraJEhpz7ObDeq9JDAYk4=;
 b=eJPDsdVTI0ZWin6WMkDuwHsJsPWT/zl4iHyMsa8rjBrzvTAnjdYQPOpjHyHmj61hl+
 1rs5Z87GtXc/c0T7FsVjnCHqR9f6VcEaUQXs/qd3aVZ4fdVSCx7KgP2wqpJiqbs8DvM2
 4iobWWhY/V4Rf/NsO7vMyjI2E5ZUbDJW+LnOuY6i3AL5oW+LvXF2y/3alMUZ06uMPwtR
 t/aY91KFzlJhu0tRM3z2oR4yRaY35Guf/Ytkl6TLZXHTzMlDI91SSF2QWcYcbJcWfpEH
 yFj+hUowvfXRh8L/A8uvkA+m1X5Ga/b4V1kzmJYDyk5z7SrLzP4MyQdON6A1ATEvo4ac
 9Ofw==
X-Gm-Message-State: AOJu0YwmWBZINXvscte2KHAVoAuTnYN//eAugz0zUV6xXw91sE+Q1E9a
 trx4fa0VRO/Rfc8oUavMd+212Ss/WamazdLESrQQRan3nCvzVW1EEK2o+1JmIUVFzO0BihkU2zh
 fUB/HflAYJa9TTMQVIyoObK1eRYOfguXbBLbok2FClaB4T1utHK4P
X-Gm-Gg: ASbGncs5qPaPhZiQCkA5bxp73EmD6E05EhFzjwPY+BHcQBas7Cwyvc/TWk+Nd7/m4Xv
 mueU+W+xTxeat8hjmJgGm3IUFRhQuG+8/W5F+SeknboNXgmIfOj+b7h9ye7gnpCruUxOIPnINFq
 l0LjI7qQ7Q0Zovw3vDGJH9UrZqfO42fFCT1mwsi5XSmoB668CWGitZ4P9dIt+gU1fmNqHd+yLBx
 o2qMP++BhZ7iCSOmo8V4df+jwZecdRMHGLG4LnQOiugVy+KRLoplsy6kqPlNH7i25opAZZse5dV
 eI53a36DKiHvnXnlIL+2iXmYW3lZlVf2vdztv5f1NRmWYP0=
X-Received: by 2002:a05:6000:1f84:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38f6f3c50bbmr10559724f8f.3.1740468053275; 
 Mon, 24 Feb 2025 23:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRmp5AvLL+uMr+rrLtQShfd1R2GlzqueESwoF4QuoBMyzWKSy0YKl774wXyqB2KY/XNuJumw==
X-Received: by 2002:a05:6000:1f84:b0:38b:d807:f3be with SMTP id
 ffacd0b85a97d-38f6f3c50bbmr10559708f8f.3.1740468052974; 
 Mon, 24 Feb 2025 23:20:52 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e70c8sm1293620f8f.76.2025.02.24.23.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 23:20:51 -0800 (PST)
Message-ID: <5a31e4fb-3e0f-4455-9941-18b00287b276@redhat.com>
Date: Tue, 25 Feb 2025 08:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Problem with iotest 233
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


  Hi!

I'm facing a weird hang in iotest 233 on my Fedora 41 laptop. When running

  ./check -raw 233

the test simply hangs. Looking at the log, the last message is "== check 
plain client to TLS server fails ==". I added some debug messages, and it 
seems like the previous NBD server is not correctly terminated here.
The test works fine again if I apply this patch:

diff --git a/tests/qemu-iotests/common.nbd b/tests/qemu-iotests/common.nbd
--- a/tests/qemu-iotests/common.nbd
+++ b/tests/qemu-iotests/common.nbd
@@ -35,7 +35,7 @@ nbd_server_stop()
          read NBD_PID < "$nbd_pid_file"
          rm -f "$nbd_pid_file"
          if [ -n "$NBD_PID" ]; then
-            kill "$NBD_PID"
+            kill -9 "$NBD_PID"
          fi
      fi
      rm -f "$nbd_unix_socket" "$nbd_stderr_fifo"

... but that does not look like the right solution to me. What could prevent 
the qemu-nbd from correctly shutting down when it receives a normal SIGTERM 
signal?

  Thomas


