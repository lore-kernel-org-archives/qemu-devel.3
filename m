Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6576DC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 18:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uizc2-0003av-MI; Mon, 04 Aug 2025 14:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uixo3-0005Cu-E9
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:13:00 -0400
Received: from p-east3-cluster5-host2-snip4-10.eps.apple.com ([57.103.86.151]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uixo0-0000lc-GQ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 12:12:58 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 E8726180086B; Mon,  4 Aug 2025 16:12:52 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=IkSU93jV9FS1GDWYWwJgNYuHfU7uKpyXDP0V+TcXxKk=;
 h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:To:x-icloud-hme;
 b=RTea5JqrDYwVRal6uMogOWig8EfcRGkyzXVtfhVyk9P6DLxbJTf/1US0XfuL6d6C5EeDdG8BOV43Hv1rYPrNmjgafGvxW4oWAVykIAu7se7cctCkP5f+HZ5u5EWycU7xQiKk+W6djv54LFR/XJIbEOJpYDebav3LBz3UUNxM04OiR9Fhu9N04MJJD85IHG2zXWmiiTY0uJejqYQvwotK6JcjH1HijIiohkoFgLBIt92RwYgOPEjSwE0XLRfn9nq6IzsTkheKN2fS7qCS1qXv1Kt+1otfrB7j2/eKZVx7Wfa/b17Pg+VRs1BpPh5frOqxqi3s10+qF4xfEqxenl3Heg==
X-Client-IP: 46.189.47.18
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 8A2A9180012A; Mon,  4 Aug 2025 16:12:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-Id: <59A4FF62-384F-4D43-BD56-60AA93733580@unpredictable.fr>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_0D194A2C-DD9F-4A27-BC0C-8FEF1BE86DD4"
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3860.100.5.1.1\))
Subject: Re: [PATCH v4 01/17] accel/system: Introduce hwaccel_enabled() helper
Date: Mon, 4 Aug 2025 18:12:37 +0200
In-Reply-To: <d18fc5c3-b68a-4afe-86b7-e1687780b67c@suse.de>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-2-mohamed@unpredictable.fr>
 <d18fc5c3-b68a-4afe-86b7-e1687780b67c@suse.de>
X-Mailer: Apple Mail (2.3860.100.5.1.1)
X-Proofpoint-GUID: t0F52muVijaGYVC1nueDfv8r7Lg4KMQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA0MDA4OSBTYWx0ZWRfX5YWKfNFnRDfN
 hY8ZftRdpqyzoB8bjLyrk8j+EGAvdelvj27qqbUr0sHvM+VwDRm6dbryCz2EijVHIZR3qXwthT6
 MZxDkX/o/7g9b5Iki2XVZ0oCCqKh3yPEqMpPwMwvSw5GRJe7i20vlPSkcr9y2fBz9E+1Sal5wvq
 GrXfFkBwSGez/6j+TFhLO7sYI4NRd4pF/ziit2QzK2hziJ2bmJPloxZMXgVKc+Eqqx1BMMdhDes
 tGqS3X6zuNPz5Z/f2RQbq7Dls0Knx2C0wwmxXwLj5kcZ6342LP37XFL9LhEE8EIFstQfOfFiU=
X-Proofpoint-ORIG-GUID: t0F52muVijaGYVC1nueDfv8r7Lg4KMQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-04_06,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508040089
Received-SPF: pass client-ip=57.103.86.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--Apple-Mail=_0D194A2C-DD9F-4A27-BC0C-8FEF1BE86DD4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 4. Aug 2025, at 18:00, Claudio Fontana <cfontana@suse.de> wrote:
>=20
> On 8/4/25 16:23, Mohamed Mediouni wrote:
>> From: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>=20
>> hwaccel_enabled() return whether any hardware accelerator
>> is available.
>=20
> Available or enabled?
enabled

Took the patch from =
https://lore.kernel.org/qemu-devel/20250703105540.67664-47-philmd@linaro.o=
rg/

Should I edit the commit message locally or will be taken care of when =
it gets merged on that series?

Thank you,


--Apple-Mail=_0D194A2C-DD9F-4A27-BC0C-8FEF1BE86DD4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html aria-label=3D"message body"><head><meta http-equiv=3D"content-type" =
content=3D"text/html; charset=3Dutf-8"></head><body =
style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; =
line-break: after-white-space;"><div><br><blockquote type=3D"cite"><div>On=
 4. Aug 2025, at 18:00, Claudio Fontana &lt;cfontana@suse.de&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div><div>On 8/4/25 =
16:23, Mohamed Mediouni wrote:<br><blockquote type=3D"cite">From: =
Philippe Mathieu-Daud=C3=A9 =
&lt;philmd@linaro.org&gt;<br><br>hwaccel_enabled() return whether any =
hardware accelerator<br>is available.<br></blockquote><br>Available or =
enabled?<br></div></div></blockquote>enabled<div><br></div><div>Took the =
patch from&nbsp;<a =
href=3D"https://lore.kernel.org/qemu-devel/20250703105540.67664-47-philmd@=
linaro.org/">https://lore.kernel.org/qemu-devel/20250703105540.67664-47-ph=
ilmd@linaro.org/</a><br =
id=3D"lineBreakAtBeginningOfMessage"></div><div><br></div><div>Should I =
edit the commit message locally or will be taken care of when it gets =
merged on that series?</div><div><br></div><div>Thank =
you,</div><div><br></div></div></body></html>=

--Apple-Mail=_0D194A2C-DD9F-4A27-BC0C-8FEF1BE86DD4--

