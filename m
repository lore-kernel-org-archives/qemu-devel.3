Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36C6EF3719
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzW8P-0005QL-Gh; Mon, 09 Mar 2026 04:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzW8I-0005Pk-BJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:38:35 -0400
Received: from p-west2-cluster4-host11-snip4-9.eps.apple.com ([57.103.69.140]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vzW8D-00072j-5D
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:38:32 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-0 (Postfix) with ESMTPS id
 5DF0A1800109; Mon,  9 Mar 2026 08:38:25 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773045506; x=1775637506;
 bh=rjdr3CgFUOwj/1J4HYiAyQnwR6pDZ1y2+2I09OaMyYY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=N5MCyyXKWWopOmngMQPZEyQfa8H1NgnpSPAGWjexc96S0z7VS12Cw7QO0zqatarb6KOIQZEiRfF2esfHEME2DJneh1zGaPkhOZozT0Q930L9rykwtbjKC2+sz7oW9JqLswaOGW/G51BSXqO34gqXUrXVe+97a3+XgomHmQitYlDOUij372EuJNi8mnvLtgCSNnYbJ71HWIoJrmc1rq1DzoQefJP4GkxomUE+GYcyzv2qe0v0SNDQcpGvYJV+tuAkuB4ot2tzSo5fITts8xc0doMyWVgirkFWPFU8zE+nyEaC+uzg7kwe92WbnvXkXerEmFqjGGh1N/yWsbMCZlrz2w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-0 (Postfix) with ESMTPSA id
 6E51A1800102; Mon,  9 Mar 2026 08:38:22 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v6 2/9] meson.build: older macOS targeting compatibility
 with macOS 15.4 SDK
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CABgObfZqDHL=kkto8i5VdpO+mEOfeZ9vYSMmVnS+T4cwNekzzA@mail.gmail.com>
Date: Mon, 9 Mar 2026 09:38:10 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <28C201EE-89A9-4454-8F8A-4FD05B38E132@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
 <20260307181856.2209-3-mohamed@unpredictable.fr>
 <CABgObfZqDHL=kkto8i5VdpO+mEOfeZ9vYSMmVnS+T4cwNekzzA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3OSBTYWx0ZWRfXz6aT2AmUcti3
 UJ3HdD/gqWL5OwOWW04axDoui6KF8mzDFiWkY5HEq2cj+GZzzO/5kP4qLRs2nZTjfceG6K6vxZE
 UECmoyCfubJoWZrPlKdlXy2FWvN4gGn6J1hOSXUYHaiJ1GFu1JIRUouY18yEExznOUNYoG6p14R
 5cmtj8E3crAwg412MKF2xUSpnqOqrBajviqvKKEEwFDZKaqV3TDzHk4s5AaEMf072jBRGqL1pOs
 Qt78o6cvZTcl0nMflhXwf+8/lOQRaaoOc0tO+vyaL7CoxJoPreIf9ZBnbgrKIkq0mUxFl14VQ1k
 p+eHFb3MSQa4WxVDkOLB40GzMYQAjObCYM9SFdcWLMrMvOcybCam7ImXDTx4Zg=
X-Proofpoint-GUID: 5Yhp4FySnkmDt0MeK9lIed9X-A5Jrh_W
X-Authority-Info-Out: v=2.4 cv=ENkLElZC c=1 sm=1 tr=0 ts=69ae8702
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wSUUvyKTAAAA:20 a=20KFwNOVAAAA:8
 a=gBkjFmi-9PnF_1lNXycA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-ORIG-GUID: 5Yhp4FySnkmDt0MeK9lIed9X-A5Jrh_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1030 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090079
X-JNJ: AAAAAAABt9ht0Y/oZcgSItetM0UyOKpSDu54vOxvQHaV/4RMsn2tVVhWDpWPZ9LoGF4Yt7ELVp1wTkQzVQHRKrB7JVCAveaD4FwOookLg88MywRwOkqLDRuOndnkcx1mOzkmyK0t4pCMbOKpkq1lChc5rUPjOuR7gLTmCDfWaPxcuypY+JrbgcgqMSOpyF9zgnWIZOp9Sl7Zj0w2P9fQeu28ZBqpEyCqEdUKX3bV1k48b2YtQm8d6lFv9jW2I493jaJxJxLsU1h3GlG0J1L9uuLC0oPOlKsCiDEvmTg/gNYiPrwQSNMp50omWr78p00nBU6ckD03qV+ZgOL6VJ7gBO4ftyz6RkcyJt044XF8WhrOxX33EBBHA8AB0Uulk7HQVrgbyvC4h0hJd1S71RovCTQEvDAAUhYx0Gz26WEirR+0gMb48jB9POr/CWzdECfdIsnARfyaK03Tj6ZQqARoq+NsOb0LBo2wl1FWbfvsLZSAejk5NfHIywY0DIi4k6IaP6/hhi1BFycGFoPzkzZ2b05qDrOm7bGREUTudsalBubv13Hs8Rw8lI87emRxPSmOhutYb0aP0dfxVucLfH2V2fCucw8rsC+yNoLNpn0hUKq4Uog8riqxobg/2zTMAeN14Xa0rj0KV4apX+tGOI4ElxCmI6Lyr+pUSwh0cmhU1xcCHuhPJrQPBb2DicER2QflRzlYSS25CPZpJ5AtNeOjN/jb6JFXCMPo9dpV3aGHLZhpbSIaZ1KaRgVFI6g68AnFWpr8knUU+XI+lkAtdnda5z4BHeGJCqIoOFjkXco3o5zxJS37yo4Ddf0DT/w=
Received-SPF: pass client-ip=57.103.69.140;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 9. Mar 2026, at 09:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 3/7/26 19:18, Mohamed Mediouni wrote:
>> Using strchrnul eagerly results in a failure to compile when using =
the newest SDKs, with:
>>=20
>> error: 'strchrnul' is only available on macOS 15.4 or newer =
[-Werror,-Wunguarded-availability-new]
>>=20
>> Working around that by not using strchrnul when targeting macOS.
>>=20
>> This didn't show up on the CI because it used the macOS 15.1 SDK =
instead of a macOS 15.4 SDK or later.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>>  meson.build | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/meson.build b/meson.build
>> index 7b4e5bc72b..78bde0611b 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -2646,7 +2646,12 @@ config_host_data.set('HAVE_COPY_FILE_RANGE', =
cc.has_function('copy_file_range'))
>>  config_host_data.set('HAVE_GETIFADDRS', =
cc.has_function('getifaddrs'))
>>  config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', =
glib_has_gslice)
>>  config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', =
dependencies: util))
>> -config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', =
prefix: osdep_prefix))
>> +
>> +# strchrnul was introduced in macOS 15.4.
>> +# Keep this condition for compatibility of new macOS SDKs with older =
releases.
>> +if host_os !=3D 'darwin'
>> +  config_host_data.set('HAVE_STRCHRNUL', =
cc.has_function('strchrnul', prefix: osdep_prefix))
>> +endif
>=20
> Is -Wunguarded-availability-new enabled by default?

Hello,

Yes, it=E2=80=99s enabled by default at least by the CI.

> If it is enough to shut up the compiler maybe you can add a =
-mmacosx-version-min=3D flag, but
> workarounds on each function are not acceptable.
>=20
-mmacosx-version-min=3D15.4 or later would be overriding the macOS =
minimum version set by the user or
corresponding to the host machine QEMU is built on.

Another way would be to have the has_function have -Werror which should =
be enough to deal with
this case properly. Does that sound better?

For meson not sure whether it actually picks up the definition from the =
header or tries to use a dummy
definition though from looking at =
https://github.com/mesonbuild/meson/blob/6e67be7492d6982d2baf153387f9adbdb=
480d099/mesonbuild/compilers/mixins/clike.py#L738

If it picks the definition from the header, having Werror there ought to =
be enough. Otherwise, won=E2=80=99t be caught...

Thank you,
-Mohamed

> I'm applying the other patches, but for this one I don't think this is
> the right fix.
>=20
>=20
> Paolo
>=20


