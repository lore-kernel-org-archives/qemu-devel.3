Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF31C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05f5-0002H1-Qw; Fri, 28 Aug 2026 19:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05f4-0002Fs-5P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:07:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05f2-0006Vz-8T
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:07:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMThjV146078
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aHwRBTlLIaCJG5HSB02N2zOJvsKfnLEpXk3uFM8p3sA=; b=LB9XfSYQqtBmTqQ/
 HmnqYBb1kx/PLm5mQX94HHvU2EA3qT0XjMZXQmS+glTyjpp6D4IfTMLqIQQLSt1N
 jfPTURkyrpunnwhlJ5GYygrrViotjwjq0B0/pHr+UqOpJvr58q9mB0p2oGY1l/IC
 jLyShPfzry3jZ8OnkFtIesUIgx544iWAr3QdAokrAzisGdZhXDL4iseimu57JYZE
 lrebXYv755gEqQciH431+4ic+vmaZWzEVMSeWu3mQ64T4HmP/9wgArmcOVnNdPO9
 w997IeDU06Rctwno/S+U0WAtfkZiU9t/TVwPAfzPkiUpoZ9Dr7QsEy+yslMvdVYo
 06ftAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb7eh2ss4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:06:56 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38ecc48b3c2so2415686a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958416; x=1788563216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aHwRBTlLIaCJG5HSB02N2zOJvsKfnLEpXk3uFM8p3sA=;
 b=FkbUbNQGVmnzL9vlbjHMmDkZuuPoHch1u1cz/KlX1slNbf09pjajhlt8Cn1+PYLMpc
 Pt3UAfb2IJUyJBH6Hf6UcginqaGVV6eKb12tiHRQc+75RC4PuO6mU83v/qtDbVQquxnm
 klU5tHqkOwzW6Ly4Sru8CPr9NZvI6IfAIoKToo/W0f0FD4UTMsCcH1QloLocBHDTZzKM
 M6UZNQZ7WWdvuDy7/U5VoMhFB7w2tms7kzC59YDTvOweJGaw5jsydEEoPOR+LLO/cchG
 SK5WiCyal3UV6zheWA0ObYE+1fSWuSt4bYfctDKZWhW+k8V7BEFEn85fA0WGey8vczla
 1ihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958416; x=1788563216;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aHwRBTlLIaCJG5HSB02N2zOJvsKfnLEpXk3uFM8p3sA=;
 b=WIFR3KpE7BWXxYx0lKfS74x1IItaMCwRUJqR8BRhDO7ZN8kEhnW0hVXAOayFyIUQn6
 RTVnz+K7r5g2AixqjUtrsUurtevuG0GnKIa+Uw4fRDTd6UnDpPsbKD1v2RdR5tfq5fzr
 9B6r55C9gIFR/qwuYhxRn0/V6LT3cna6nWlfS/wEhwa1IeCrSybGaxfnewuQBF9CYbRz
 1n4P2PuY1UU9O8w/NuI2lXvtuFI8q6TK3txVmuJo1LG6OzuWSffzjOB0SNfWf0z5RgKd
 JE6qkuP09Pbn03E/5tF47cPRrSFeMAPeWcLnwy3ESQSxQ5PPXiDh4tlHj4UjnYP6g/T+
 V12A==
X-Gm-Message-State: AFuF++m9E4VdI02GqRkmP2Pow8Q6PtgobI8cvD6Z8ke9BMzmvd9MO40B
 jQGjE6QJCLNnxZFrhtBpJ2NIlqXkDiylVdCcvJBNDPpcnTqV69WcUH7OlRoBDCkSpdUlOK0HnYF
 EUuPIA0Y0FD70IuvrcAH4hSmt8Sw/ajogd0Glh4gp/eMe3Wwti3n0cQrzS9qG9alCGw==
X-Gm-Gg: AYBFou1lbVDS/VaXHr1NL9lFYe+Uqn4tVAQ2hUV0QntApXezMMJoG5ozEFnteBCCKCN
 AHX6G60eqV7RGJVJ/jvDGMkECZ46xyaLVdkatoIl8psalw7y6cZraMX363z1ocvq+sEkzFcZZ8P
 +A9mx1iGG++MoH1aHdp/+x8AAPOopEcTnIfSVswDHW4D31tynmitKaOm7O5WiOvb/ubPRfBlSEQ
 N8JZvPvo/O2HBRan51uvB71cb80G8M8htiX5oZodBG1aDB4G6fk82XHDpW8CeMHCvQlPcgzkGvZ
 kovBFX6rAq0iRV2MO7ZnrygY4N6daBRsjivE5Em4VnQnYnGqQkc1z8L/JMKP9L6iCFyPdz8i6wn
 TXnyXWj4rwWRQLnkOaHh0JFHts19EIeYrEoJXVx9azKu3xkkGpj95iFFcJM4BYPOXms/w
X-Received: by 2002:a17:90b:3a45:b0:396:5785:843 with SMTP id
 98e67ed59e1d1-396d0f09a46mr19253988a91.8.1787958416352; 
 Fri, 28 Aug 2026 16:06:56 -0700 (PDT)
X-Received: by 2002:a17:90b:3a45:b0:396:5785:843 with SMTP id
 98e67ed59e1d1-396d0f09a46mr19253918a91.8.1787958415784; 
 Fri, 28 Aug 2026 16:06:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286fa20e2fsm9088138eec.28.2026.08.28.16.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2026 16:06:55 -0700 (PDT)
Message-ID: <c44861b9-9fb8-49ca-b0e8-51875b009675@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:06:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: implement dynamic filtering for
 machine types
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, philmd@oss.qualcomm.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, anjo@rev.ng
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: IGLkwPq4Wykllhp1DfUY51R2WkGxYK2R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMSBTYWx0ZWRfX96XHqxUnLAR/
 8l1hpgnsS9kIgilairUJ4cp5AYIUtW36C9TUWzeo46xLAx+hf7qCdKp7kZg1mdcnPlqRncX4hCo
 eIW0IdeCPw2D2BFzunYLY3q9lzWeaLSFBqJgEnoGv8fda+bj8HEnBkZFfFq2XEPsDrCF1HpgM5z
 2xT7BhKewAe/d9/ZtIXjS8o1PSrl1BWDqyoWPP2Ly5zGRFGsVeCRpm3rPw+Q8oVS0Jhk7DskvOr
 6hpwLmGTsHkUzLK7nqz+7qyuQDIHQ5kwHGzhWtdHMjwI7ljFdsP/CC+vRauW6iy7i9Zxi1LIjsr
 K+GAUYVzZI4euEha3ZGMAg3gOLOSL6tSrqg+DixnBJ50decd+LVVfi59NaF8FmW5Dx8f+Xj7tlM
 RowZHcOd0Sb30SAGAbhhYBba4TvjnK5nzoF2Fnwt8oVn7ofmSF5L0xjIsy4YX0MExd/ueO86O9H
 3XlDHxmTnPmHhSKlhfA==
X-Proofpoint-ORIG-GUID: IGLkwPq4Wykllhp1DfUY51R2WkGxYK2R
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMSBTYWx0ZWRfXxYbQBC0pNHtP
 bWLQHk2aLN1JE2gaCpILjYxdLJS5JomJT2F1aI8i3SsXjnNrlywcZIoJ6o80xEhxc2s4KxrWT8i
 +4kLGLrq42o+vi4Nioi65d8/cQRjHbo=
X-Authority-Analysis: v=2.4 cv=RoP16imK c=1 sm=1 tr=0 ts=6a921491 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BIMoBbIzgqyw9w_Ie0IA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280201
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/21/2026 4:51 PM, Pierrick Bouvier wrote:
> Now that we can link a single-binary with at least two targets (arm, aarch64),
> we want to make sure that we expose the same set of machines (later devices and
> cpus) than target binaries. For that, we implemented a static filtering based on
> target interfaces that each machine will implement to declare which targets have
> this machine.
> 
> However, we discovered that this static filtering is not enough. Indeed, some
> machines and devices do not depend only on target, and their presence can depend
> on Kconfig or host/target combination. Thus, our static approach can't work, and
> we need something more flexible.
> 
> In v1:
> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single function
> bool is_available(void). From there, any machine type (and later devices and
> cpus) can implement it to override their presence for each target.
> We first replace the existing static mechanism with this, and once done, we
> cleanup all the old interface. One nice benefit is that we can get rid of
> config/targets/*.c files, which saves duplication.
> In v2:
> Suggested by Daniel, we share a list of requirement for type to be available,
> for future introspection needs.
> 
> This series was tested by comparing list of machines for all qemu system
> binaries, before and after this change, to make sure we don't introduce a
> regression.
> 
> v2
> --
> 
> Changed the design to use a list of requirements instead of a callback.
> Implement it on one machine to show usage and get feedback before going further.
> 
> Pierrick Bouvier (2):
>   qom/object: add available_if field to TypeInfo
>   remote/machine: add available_if for x-remote machine type
> 
>  hw/remote/machine.c        |  3 ++-
>  include/qemu/target-info.h | 11 +++++++++++
>  include/qom/object.h       |  5 +++++
>  qom/object.c               | 10 ++++++++++
>  rust/qom/src/qom.rs        |  1 +
>  stubs/meson.build          |  1 +
>  stubs/target-info.c        | 11 +++++++++++
>  target-info.c              | 13 +++++++++++++
>  8 files changed, 54 insertions(+), 1 deletion(-)
>  create mode 100644 stubs/target-info.c
> 

Sent v3, using a callback in TypeInfo, as suggested by Richard.

https://lore.kernel.org/qemu-devel/20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com/T/#t

Regards,
Pierrick

