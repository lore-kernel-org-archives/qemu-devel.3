Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CAEC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 16:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUSbb-0002VK-MS; Wed, 25 Jun 2025 12:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSbZ-0002UO-WA
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uUSbY-0001Ko-Dx
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 12:04:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750867447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l7WoL2chUBJK64mJgDJcG1YShJxhwGwDXnKNJT/hIlA=;
 b=hfVJDUsbMnRfrmlaHXqUyh9esNeWCYjPTJ5RXPqKi0vNvTyvOMud9LR73mdvQL51lrGt2H
 ZFUdDUNHiS5JSbgvyluAFZCbTp2HKC4wpCA17Oglj8ulTEf9Wx71SxoOrx89JwnIQtz2Nj
 6uwYvM7hxjb3Fqp8eijy85vbZs80npY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-TCsRkNyJMqmDg3st7vIVdw-1; Wed, 25 Jun 2025 12:04:05 -0400
X-MC-Unique: TCsRkNyJMqmDg3st7vIVdw-1
X-Mimecast-MFC-AGG-ID: TCsRkNyJMqmDg3st7vIVdw_1750867444
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3696a0d3aso3087772f8f.2
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 09:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750867444; x=1751472244;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l7WoL2chUBJK64mJgDJcG1YShJxhwGwDXnKNJT/hIlA=;
 b=L0psQCCYPHKKfcab/Zzpez5Dm/omMxd5lYH8NtEOPOJusqW6rDtzxwY0t51pGuuF4U
 u4M3qacDTls1zpq9xjT9AvQzHervqNIKvcJpDAO83az7jj8SloxE/XsYim3rtc1sSExN
 u3EuLOrJwGJn/zRmhRZ76nkysj98R769y9/rqUsxEIaeoYzROhCHb+7+fomRS4qCCpx3
 dNy5uUiHPZC4VJz1lQwdXb/5mhJrOpRmpXk+TJNDVOmW0yOTz3C1FkImHdESed1zByXc
 veIa5q0vdFlvIv++8IM/oI+fIPHAOJW4HjeavfFsqioEZ4PWWoFvzcXzoQ/8K0NYPKQK
 N+eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2M3HFH696Yb75So0Da27Hg9Ramgk5Vw/m58aDP/CjAVkjNRbxf9dvpX6dFJPOIY3mAmZnJKlB+cdO@nongnu.org
X-Gm-Message-State: AOJu0Ywr4COnHb0hGLhQvMxWQNWSecUT3rGDrCyLTfjJx0S+Tx2SQbJY
 o6ACYXpD3azb7IpVnaNGDJzVaCRJgZYpPqgI5QfIQj2NR5G6jMtI6HHUByaLbuvb4qXZj0MC540
 fiJaOZBQ/cR3x+gcy7XJ+3qa/IDny3QJHV16eo6ahk3OGo3e6xrsD4sV7
X-Gm-Gg: ASbGnctDiDE0fjoF1J45htivk72xQOHAISCfpDCWC4o2l8KfkzmQcMu7RdMVQpH4JGS
 t39REx62EEwtpKnV7D7G9UzrYF1HnSayKB1Td86BVPxu50ESONcLUGLDXCwo6ohaxfHfsClp42k
 k7WdVlOit221KpZo6FJBxLRs8B6bvs8elUutOfM6nAyCo+DrRzfHMJg5RGJ9KqQpuwgHOnD2sH+
 HDMT8FTD9PfksMNtYc9pWrmvbSQYtQW1XvcLnV0k3s7+L7hn0JVAc8KBUGvxKxltMyQQB+N3RTy
 Hn92cXV9ymgCUP73k/dvBWGhKm1//+mm27X0QjP+B0OMSWurPo9zBGx+NtDNeoI=
X-Received: by 2002:a05:6000:230c:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a6ed604835mr2558508f8f.19.1750867444180; 
 Wed, 25 Jun 2025 09:04:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS0x/jPJJ+rcLlLRM4j2oQQVEJTK3E0NcGqVWlQAN3Sk7aGYrlzqGS5erpTULUbuB2EUhMPA==
X-Received: by 2002:a05:6000:230c:b0:3a4:f902:3872 with SMTP id
 ffacd0b85a97d-3a6ed604835mr2558452f8f.19.1750867443584; 
 Wed, 25 Jun 2025 09:04:03 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e810b140sm4942117f8f.80.2025.06.25.09.04.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 09:04:02 -0700 (PDT)
Message-ID: <d087e9c7-9ff3-4125-bd84-27d874166bb9@redhat.com>
Date: Wed, 25 Jun 2025 18:04:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] scripts: replace FSF postal address with licenses
 URL
To: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.09@sean.taipei>
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
In-Reply-To: <20250613.qemu.patch.09@sean.taipei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 13/06/2025 18.51, Sean Wei wrote:
> The GPLv2 boiler-plate in scripts/device-crash-test still
> contained the obsolete "51 Franklin Street" postal address.
> 
> Replace it with the canonical GNU licenses URL recommended by the FSF:
> https://www.gnu.org/licenses/
> 
> Signed-off-by: Sean Wei <me@sean.taipei>
> ---
>   scripts/device-crash-test | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/scripts/device-crash-test b/scripts/device-crash-test
> index da8b56edd9..1ecb9663ae 100755
> --- a/scripts/device-crash-test
> +++ b/scripts/device-crash-test
> @@ -16,8 +16,7 @@
>   # GNU General Public License for more details.
>   #
>   # You should have received a copy of the GNU General Public License along
> -# with this program; if not, write to the Free Software Foundation, Inc.,
> -# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +# with this program; if not, see <https://www.gnu.org/licenses/>.
>   
>   """
>   Run QEMU with all combinations of -machine and -device types,

Reviewed-by: Thomas Huth <thuth@redhat.com>


