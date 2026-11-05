Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988E7606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=me.com header.i=@me.com header.a=rsa-sha256 header.s=1a1hai header.b=aUAzLyxK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOyKe-0007DO-0K; Thu, 05 Nov 2026 09:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1xOyFG-00067S-8Y
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:15:14 -0500
Received: from ci-2003f-snip6-11.eps.apple.com ([2a01:b747:3005:200::3f]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1xOyFE-0000Ba-JI
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 09:15:14 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPS id
 6BA38180125D; Thu, 05 Nov 2026 14:15:06 +0000 (UTC)
X-ICL-RepId: 01a1ac10-3765-7167-85d6-1f7bce327462
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhPHVwGRQNFC1YCWRcOVk1NEFwfRw5YMFQdHQ5YBhIWXUVeCBkIXR0ZClBQAktaFVUXDgJCH1AfTBZXQ1QCHBlaFFwYU0VRH1RYQxlFVmlBC08dXRlbHEJkWFcJCgZXXloXXk1aAlZNBU91WAQucEJ4VQQoAS8fRApLdUB2LQRGFDx2WHQuC0UJPAModStfFRcbXAAJS0YJSR0OBFQHXQVd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1793888108; x=1825424108; bh=T4ypooSis23nmXw2oOpM+nl5ctWhpobWCsPjHXKF0cM=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=aUAzLyxKXBVYe/ehUa/V6cx3Zmv7loiY58fOdJWH4GVXy0QkG0W2kZcgNAoeqcO/+Dl6LvJtTZFCClR7P8IV6JgkaqEiimTXItegQWiPKUIFtctV22kCVpgrMshCxyKBGeN72grG45aBYwvbvRCB38r4Qev8VgNFDyARwhA5KBkvnr0hUbMGpdLUoEUNYKaHxsYJb7ZRbHqSy5tgNi2kPrftloBw2ps7kpp6e6Rgit7dKAf/OBfzDc9Midhu1JRNpnZ7duWQggu8VVieHlF7PFe7wqYFnkVWqwkLn8ikHCwI6+XnXZzsQD5L6lLf4cDUCAEdwGfq+SrKI6Z5cK6dog==
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-11 (Postfix) with ESMTPSA id
 DB47018000DB; Thu, 05 Nov 2026 14:15:04 +0000 (UTC)
From: Jason Thorpe <thorpej@me.com>
Message-Id: <7F53EB2A-7E6D-433F-AF66-DE5CE950D0EB@me.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_3E350882-1D28-473F-BD3D-B19CB5972F68"
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2] mc146818rtc: Make PF independent of PIE
Date: Thu, 5 Nov 2026 06:14:53 -0800
In-Reply-To: <b9960b3a-590b-442f-a95f-e21a24ee00ed@oss.qualcomm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20210619193849.27889-1-thorpej@me.com>
 <b9e20dbc-fa5f-1e37-ad8a-5d433d77c4b0@redhat.com>
 <00FB4F43-698C-4888-91E7-45FE80CCFC67@me.com>
 <bf3645bf-6a47-75f8-862a-7ea8c467f007@redhat.com>
 <b9960b3a-590b-442f-a95f-e21a24ee00ed@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: 11AueTfaCqfPl0ygRuABS4ZxTWcl6D60
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX+3gEaRYpJs6C
 wY3EIaJHjVxOQLFdhTTtURODsx35hSkbUv7mQyGTHEKajfcKPTSn9CN3OAy6D8+ITVM0wtOfoSi
 Hm+HuPP7ro3KqfnVXXKLmprnKMdohtSz373ZZhjExHVA8JHA8Msdhp3YCzULFf0ortPrWIlHLh6
 DBOFxagRe7h5uutaU7YiHKj0KKms+eUl4elWbckk6D81W7NRa+R3ZxAgbbaZH0U47o48RvIRxy1
 RnzewbYLRtFEw1qnlC9GGdKZgAhD2bk5KB39uBOPGwEh1nd9D/8kE97zINV6k+nSqBlhOVIxy4r
 jr8kasxA9p4fbLVCQZvE6x+eiJjMWXHirUGcjTsOm/JbyH9IN10fatfKQACjgY=
X-Authority-Info-Out: v=2.4 cv=U+qfzOru c=1 sm=1 tr=0 ts=6aec8f6b
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10
 a=hNn9FkxD5tsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=fcMS4clZAQu0tQEkvZ0A:9 a=QEXdDO2ut3YA:10 a=ZGgYWE-smxwho2_n9wwA:9
 a=YMBgh0loWKcPU2U1:21 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: 11AueTfaCqfPl0ygRuABS4ZxTWcl6D60
X-JNJ: AAAAAAAB5lVq9dqfq6W6+eLqR8NMAWfsZp05xzNTA+ljYxU4A2O7ce4uaxSFcwYHko4E49
 7MMylsIhhy5BHhaYymWUaaD33pM+IdwwKmS1MRR7pnQI66gjF3jNr4Uyp0U0Achi5m1acS
 gSZ8sJdZBVgMhelaJ69AwpekiTQIcvDOwhsmy7CZ8EkLTNzU1T5E3Yds9jWtNI29A3fexl
 PN/MWDuWdu7WgKLWtQ57QLg65oB5o5G04Wgc9XWHqMkWtob1WeHm/jGFOPzghdLzahtxCM
 A9tYNufry8UP2saEPqXNiKjIiWYVjJzF4lIhikqK7Q8z05/JrTmuT7OV+eDFl0KvTUtn6i
 7bHqOSB6yjsgQg6ELtwjIcxJdIjvKZoGZpy2V6YBPgXVq19HURF3WylT7pPak4CPNqZokW
 vyidcoFRxflxmyf/J9zSn+T3BK9XxBveyq6kFLdlbY1qY8RHcd19n1328Utf2NErTo22ss
 oxZnFvMMcczV7gLjhA2zVs4f2Rn31qagDUFTxCdKkxT9NDAVIm/2Y4gCKJvPRDYD8quzrA
 25fWbafJBC3cIto1s3K6Orx0rAqbiHwlXfCG9ORnM2HBwZqlbjUd2B4doginZ0LTL3txTs
 vt4LIKn2yu5f0+O3q7wJ6+R3cb7A5b5rjjqgUjZFuYODnJGnfS2Q5eXdTaEYqC2Tha9BRk
 Is5bOPiBXuCwJatXcIgtIVcuNrcpf9buMFwtUHpf2yIE/HsQ86ujBNHU5vOdqqVXH8eEZ8
 U15FY+olTn0FxInmwr5hes4mUVUI8hSwMcKKYcfIcMrRhnDG1k4eJN/2tp0uohWGfnMFRf
 YzYK2cS3io9J3VyOBPU4mG0ALe+KH9h2kW0jebGrdxt91iRjn4+yRkEo2AUWTcbdE4I8jg
 FChBKnXGhsARTjra/LS9MNdWQocLAZTBNsD+uYl6LhfgTCKE5wemeskn+3HuUvzo5D+Xcg
 rbb9ohkcd1wa3n4whYQXulnPKKVxNF6fet1CcYAzTvWgbt/6nBGsQ5KlFnUs00ncgU4dDv
 Jc38mdVOS5a99SGG0ejDUBBa1NkUNVxgFNTBWiInHuTBiofrRKvWzNwZbRgWeEom6c4+sC
 EW+b8TTht2TBec2m+1WFp8lz+GbVbAsVboKkT9PxHsU0LVLuvAItc1aa6cAuXI1snreYEs
 4QwK/6q7f2/YWhMAqNIYq/tXekWTB0I2x1BPUTiZe4/H0a6bGJtnCfDAZrdwrNCSP5qSBL
 6CzGre3FN9Veae3zFuRjoYh++VSVR7UDAIoYXrZnUKKCSTSk6wAzGKzEUUV838iIneZ20c
 ap/kJphTrLGt3Xfr5l
Received-SPF: pass client-ip=2a01:b747:3005:200::3f;
 envelope-from=thorpej@me.com; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 05 Nov 2026 09:20:42 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--Apple-Mail=_3E350882-1D28-473F-BD3D-B19CB5972F68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Nov 5, 2026, at 5:44=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> Jason, do you happen to still have your setup to test it?


I can do so later this week, sure.

-- thorpej


--Apple-Mail=_3E350882-1D28-473F-BD3D-B19CB5972F68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><br><div><blockquote type=3D"cite"><div>On=
 Nov 5, 2026, at 5:44=E2=80=AFAM, Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@oss.qualcomm.com&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div><span style=3D"caret-color: =
rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; font-style: =
normal; font-variant-caps: normal; font-weight: 400; letter-spacing: =
normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: 2; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; text-decoration: none; float: none; =
display: inline !important;">Jason, do you happen to still have your =
setup to test it?</span></div></blockquote></div><div><br></div><div>I =
can do so later this week, sure.</div><br><div>
<span class=3D"Apple-style-span" style=3D"border-collapse: separate; =
color: rgb(0, 0, 0); font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: 2; text-align: =
auto; text-indent: 0px; text-transform: none; white-space: normal; =
widows: 2; word-spacing: 0px; -webkit-border-horizontal-spacing: 0px; =
-webkit-border-vertical-spacing: 0px; =
-webkit-text-decorations-in-effect: none; -webkit-text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; "><div style=3D"word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space; ">-- thorpej</div></span>

</div>
<br></body></html>=

--Apple-Mail=_3E350882-1D28-473F-BD3D-B19CB5972F68--

