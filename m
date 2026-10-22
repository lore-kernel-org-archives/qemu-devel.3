Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE835606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=as3/hXbn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hrGL5PbF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzNI-0001WU-4P; Thu, 22 Oct 2026 16:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzN4-0001TU-HT
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:26:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzN1-0007Lz-Oo
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:26:42 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVU13078089
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Zh3qks8RqV8JoEAOmmMQ5V/nT0FLNvPGMZd2kZ9YhI=; b=as3/hXbnU7YTP3xT
 uQHrmk9TllbJuK0MWgQ0WTpnwNXf5qenw6XqjTqLOR2l2F08LhDDIHTDdycGrDjz
 baJRAgflsfb0FWfr5BdhHRceBUK7sCarwKaym557+yZ/8w8m5vsAUW+cWe2K7Njn
 RC/a0gtqFzrSjXhztQ6/CcXfRDjhNENm3VxA+uOHVTzZg3qvXMOL1/G/iq1hybKE
 9gQL0EBRnSEqlAzvrc7IAUCrDUICmXd1OwxGtZq4pjzyIBKmLeDvVbD1OmizM5Oe
 tNrJa7jzUz62n0FNBEJDdsTW23pGLw0Nk/B4QXrdP/paKKNJVmZQoTaxYxdAOYEa
 J4L8HA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ancct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:26:28 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36998507c13so238556eec.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700787; x=1793305587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6Zh3qks8RqV8JoEAOmmMQ5V/nT0FLNvPGMZd2kZ9YhI=;
 b=hrGL5PbFDZC8SRa+JGRURgvQv6pSOZqlCnnzFj4zyfZJXx43Lsi9Y4kKNGT/8lSx6l
 ubX5vyahlOLsOWkOo2Dzv8ZyJ8FxNZsPfuF6wy7IQq1RuuqgSbpnl9VyBpMJ/kKWR3Bq
 P0YOSFPzSKAzaOklNCP7nZUzUcpinkaLQkt7V/8X/pxQOGahKp+A82PSLyHhRiKiBo5t
 fVOELtkbly2Ci3fWSDnHwNG9VBHhNEeQAVda8E3hHhTdnJdSopGRWoB6PCpuPxY7LPQT
 tno/w4prPOaGp4CuUBkLE5l3e1FzgUkdYXs0W6UhoasFgx6qboaEeUZmCmRHFvGxqKgQ
 /Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700787; x=1793305587;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6Zh3qks8RqV8JoEAOmmMQ5V/nT0FLNvPGMZd2kZ9YhI=;
 b=bTXFemP3rHUN5HNFs7qEus+wEa82LVXvl6kx+WKVWy3L0HHS72Q7df+59ySJtMhIWV
 Iq1hcQJtY+rZzW3gXAgTJRcZ+3GsrMn3AQAog80BiX7Hn3FsyB9SUi7BV69LWpDQ0BhD
 4VEmlpkRE5qhH5jCfQj4my+gfMIX0EzK8SvdrZEp0BPjI/T6uUH97RSl/7ahDWJvQZXU
 Hfr/98CPfkmSm7UYh8JjYALlW6DyVf9/eeEAwZysuVsH+nsZnlxg+SAkWV86XwH56BEI
 7yvQR1A/TXejxScrNEzP1Z2ly0yjyHb7kprklq6LQHaIZ31useUwGbc0KSI62uDVnwOj
 tudA==
X-Gm-Message-State: AFq9FYKKIzTJ7TVZzHeqICuGNFqbQyaNQjrwlKvDnUFoDadx9AgYaDCK
 5dSTu04nOOEDJDMKpwAY3r0+HwBZCrIGUcc5NA88sf/gA3G5621G8W2fFSJ+KrWJRKRilgIcSpa
 IuzZisAeibsJ0OCU9VximMlfuG45X9ROJ3g9reY1YAqfasKhyTdmdmQrDhJJ0uqFTmA==
X-Gm-Gg: AYBFou0KjQw/NSleq40K6eOINAFRVARvLKIDqz1luN9giHAGhjfFmXzFZ8Jv/PrnHt4
 f0wMU257f5BMRRjY3mYMBHKAmxvBqNWKgwL4Eji4JOfZ65vwyoHiYT4h426CpdCphpZNg9PChee
 bGvsQAakeu2PIf6OrxNvKmy6Cj1U2ZbI8gCF3iTK/SjBjEmneyIiZ5NVuSnY87aSaS8jQINz45z
 parswdcjKFny/Jb+xugYzQn38Fci+WDWY4O4kGHb9r4gvN0K/VzqvCB7LRTOoAD/zS6inrSjJRA
 LNxAnw9jAN+/acl77BF24/RbQ4hP36RhsjqeRSjqx0gbChvNz9YOtjdNLzAwAQr7tP/Cfo1V825
 KBriNC2XPGuHVbkw6s8Y6DHFPq7genLp0h3XmbwlNgiWZLOlNg2kEuRPLm6dXwO8TCAgCZw==
X-Received: by 2002:a05:701b:4194:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-195971822b6mr663868c88.0.1792700786936; 
 Thu, 22 Oct 2026 13:26:26 -0700 (PDT)
X-Received: by 2002:a05:701b:4194:20b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-195971822b6mr663845c88.0.1792700786268; 
 Thu, 22 Oct 2026 13:26:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195eae0e830sm253886c88.10.2026.10.22.13.26.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:26:25 -0700 (PDT)
Message-ID: <bb09751a-b13c-42a0-95b3-eb7f9a8dea33@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:26:24 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfX7XGzvitkLYlF
 wdGL6PTzGVXfUSVhtOyeCoCASanSF4n7IB6YYvTp6lETdrKeFyJc/gQntKyJxJBLZzKINxguYCA
 1dGuESDCEk/2guOQXELZkMVDBkb8/Yn897IIgx0sJFPxtD3pMK8RkumokvpaYoSoGqqvRDljh/x
 leO3mJJqvKAW2coPvLdHqs1dbDO61eECMvVE3b4GxM/GKHKVWhbTOAwf/k+w1CBVbu8/cFCCu0e
 0vyKpA6lDOzLtX1PXiVPSyxEQ6VgZADqfZMm+i8+y/DjCKY5z3j7eekPO5PlNel1X1dGfH1Y9XS
 l3OsG9/qEd/26xQ2gi3ZB+yAcUzMmvqpWXQ1y1jJowequ49KbGM4f8iNiFivfGbEF9g2x7Pqu+g
 xc2R/inImf6bqrfkCigJeeZCaKCasU0obI8bjSuE+FBtncxIb03fsbWnK3V6MLH/zCh2/+1PEGg
 1n4GrHRMMuVInL6FZiA==
X-Proofpoint-GUID: d8B8ok0KN6oB2hrlJfgIaxgGULDr-pbf
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ada7174 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=K0n9163o_ZiLdAbZwhYA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: d8B8ok0KN6oB2hrlJfgIaxgGULDr-pbf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfX2LElnLrw/iAM
 IsLLGSIb6yqE0BOWK9ZM9G0rtEXIbY6Ls1BMwyP3albV8lDsSyh8ghhT+Ni0CD/gro8kwWI/BRA
 i76wW7XnwzhHXq9idi+aSrKVyc48cXA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220081
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/19/2026 2:20 PM, Pierrick Bouvier wrote:
> When linking multiple targets together, we usually have conflicts with helper
> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
> would be better to have a general mechanism for it, so here it is.
> 
> A previous series attempted that:
> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
> but it was relying on (binary) symbol renaming, which is not a portable solution.
> Instead, this series approaches the problem from source code directly.
> It requires more change, but it's cleaner IMHO.
> 
> Series follows these steps:
> 
> First, we make sure all helpers and definition are using HELPER() macro. A lot
> of helpers were already defined this way, we just make sure it's exhaustive.
> After that we don't have any 'helper_' left on any target code. This is a big
> change touching the whole codebase, but it's a simple mechanical change. As long
> as it compiles and links, we know it's correct.
> 
> Then, we introduce the prefix for target helpers. For this , we add a new define
> (from meson) that applies to all target related code. It could later be used to
> prefix other symbols also, that's why it's not named "TCG".
> 
> Finally, we cleanup the previous manual helpers prefix that were added in
> codebase.
>

@Richard: does that series works for you?

Since it's touching all targets, I would try to upstream this before the
freeze on November 2 (ideally end of this week or early next week), to
limit conflicts with all the people sending changes touching to any helper.

Regards,
Pierrick

