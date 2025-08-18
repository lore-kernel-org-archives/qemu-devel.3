Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94667CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1untmM-0001oq-Nc; Mon, 18 Aug 2025 02:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1untmK-0001nx-Ha
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1untmG-0002tk-Es
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755500130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=dunrkIlhdVhj0/xgpf9Ljz9afxpZ8M27hBG8QS54l84=;
 b=Kn2sj5sG39TI83jqDUD3ATtV9Yhw9hlASt2de3o7L/+4NsYi9+6dUaRPBbGGV27t1msZUd
 AwBBsp+98mlmL+/WPF6C7n4nIDQ6HXYAF1V74oezN/fzdczEV92WTxvS9bPsTE+lPgQv1W
 Iqc8xb55nB4uVXyFr5cPEbzNO73xNHI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-O7jnaJqlNYWoQSlF7mJ9lQ-1; Mon, 18 Aug 2025 02:55:28 -0400
X-MC-Unique: O7jnaJqlNYWoQSlF7mJ9lQ-1
X-Mimecast-MFC-AGG-ID: O7jnaJqlNYWoQSlF7mJ9lQ_1755500128
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e870627e34so1824471685a.2
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:55:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755500128; x=1756104928;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dunrkIlhdVhj0/xgpf9Ljz9afxpZ8M27hBG8QS54l84=;
 b=wxcuwBQENuLydr41sWYAAePAsKQ+sMW2cYjiWfmKNI774OkerNzWWAVVodemCg57sH
 0uSdJCcWzpuD61/vYHrG/FVlrWR2NzeULSrnLaZrhTFyuKqjeHaxad+ISPJoxyLZzJCY
 toFPIqoESwJ8Ky4u5FgjPihUaRwCHKiYsvEm9eUC340w/o8vWBTXAj4asNg3ypp724Fg
 OSkHLSTsHmu/lJo8pN9Jn0rrs3+cjyL7B1UM+G2kv5yfeKQ3tz8qiwo40qG3ZMLPZPeb
 vm7tRDUeKPx2QV2OGejrQZ+HCSM+dx44OrmjWLZRp4QggCdDfOANeHLAHmwZjjHJfCxl
 8FPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYbLMC5y5UNQlSRRazZv1se7N6r12hJ5++5VQeF3ZlAybIoWAs/OAtMP1zTFj9V+344AH3v/k0mVF/@nongnu.org
X-Gm-Message-State: AOJu0YwBzuQO+A8MDI+uLwNoHwrkW/bc4B16RtGCRskArGEESb5VXqFy
 iVbbbMgqfoZ5zHRxUrPIuOO67GqKRNStoqXkZvu9LX49dGEXah/XXHThAHcC/rVDAiiZGrL5VFq
 U8vMhDMbNAFsEYB6em0NlnwvaCnOA6gVQUBbKM23QWBYuBmN0o3e2s6Q0
X-Gm-Gg: ASbGncsc2xk86rI6Ma6xZeo1NNou1wbNGCyAgp+9l5tRZ20heTXMtbIwg6Xn6As0nTK
 7wHkZ1eSVaUFUCktNPww1209FmKnyeTy/gY+r99ebourngXN88fEr2xmIizq2ito9psvOhNP0Kt
 KDOrjDMFjw4Z6vVRoMxYtIqO3yMMfwqO/PJlxhms326MJtkDCXnPeW8d058K9DfSDEMMn5907zz
 06iaP0hmbUwnFg5UGV3whpG4Dyzm6hIJi6UmX6S+8rPegkwK6gdbapaRsbIpMj3X7t+pgVBBEyC
 glF4TBmB+lDPTicA/s6KbDmkCns/8wKZyQ1pDKt6V/a9pSNfamWf2N+WJODFxY8GysM4ESNCaif
 6IhQ=
X-Received: by 2002:a05:620a:450c:b0:7db:9b82:1276 with SMTP id
 af79cd13be357-7e87e0233e6mr1223453785a.22.1755500128183; 
 Sun, 17 Aug 2025 23:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ3SjzeMwAvvVFblk38TVE1P2ZPULZmTUiQN9O3hAz8FTuHKcrwjIA/BAkd4GAJ9z7RfDovA==
X-Received: by 2002:a05:620a:450c:b0:7db:9b82:1276 with SMTP id
 af79cd13be357-7e87e0233e6mr1223452385a.22.1755500127835; 
 Sun, 17 Aug 2025 23:55:27 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-113-055.pools.arcor-ip.net.
 [47.64.113.55]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70ba92f870dsm48092116d6.39.2025.08.17.23.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:55:27 -0700 (PDT)
Message-ID: <0ef6ac8c-06d6-4e65-b7ee-ef8bdd22ceb7@redhat.com>
Date: Mon, 18 Aug 2025 08:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/33] test/functional: exec_command_and_wait_for_pattern:
 add vm arg
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com, 
 peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net
Cc: sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-33-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
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
In-Reply-To: <20250813164856.950363-33-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 13/08/2025 18.48, Vladimir Sementsov-Ogievskiy wrote:
> Allow to specify non default vm for the command.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   tests/functional/qemu_test/cmd.py | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/cmd.py b/tests/functional/qemu_test/cmd.py
> index dc5f422b77..28b36a3a54 100644
> --- a/tests/functional/qemu_test/cmd.py
> +++ b/tests/functional/qemu_test/cmd.py
> @@ -172,7 +172,8 @@ def exec_command(test, command):
>       _console_interaction(test, None, None, command + '\r')
>   
>   def exec_command_and_wait_for_pattern(test, command,
> -                                      success_message, failure_message=None):
> +                                      success_message, failure_message=None,
> +                                      vm=None):
>       """
>       Send a command to a console (appending CRLF characters), then wait
>       for success_message to appear on the console, while logging the.
> @@ -184,9 +185,11 @@ def exec_command_and_wait_for_pattern(test, command,
>       :param command: the command to send
>       :param success_message: if this message appears, test succeeds
>       :param failure_message: if this message appears, test fails
> +    :param vm: the VM to use (defaults to test.vm if None)
>       """
>       assert success_message
> -    _console_interaction(test, success_message, failure_message, command + '\r')
> +    _console_interaction(test, success_message, failure_message, command + '\r',
> +                         vm=vm)
>   
>   def get_qemu_img(test):
>       test.log.debug('Looking for and selecting a qemu-img binary')

Reviewed-by: Thomas Huth <thuth@redhat.com>


